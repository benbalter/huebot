# frozen_string_literal: true

require 'sinatra/base'
require_relative '../huebot'

class Huebot
  class AuthServer < Sinatra::Base
    get '/' do
      params = {
        redirect_uri: redirect_uri,
        state: SecureRandom.hex(5),
        deviceid: Huebot::Auth::DEVICE_ID,
        appid: Huebot::Auth::APP_ID
      }
      redirect client.auth_code.authorize_url(params)
    end

    get '/oauth2/callback' do
      headers = { 'Content-Type' => 'application/json' }
      code = params['code']
      token = Huebot::Auth.token(code)
      token.put build_url('/bridge/0/config'), body: { "linkbutton": true }.to_json, headers: headers
      response = token.post build_url('/bridge'), body: { "devicetype": Huebot::Auth::DEVICE_ID }.to_json, headers: headers

      if response.status == 200
        Huebot.redis.set 'token', token.to_hash.to_json
        Huebot.redis.set 'username', response.parsed.first['success']['username']
      end

      dump = JSON.pretty_generate(
        token: token.to_hash,
        body: response.parsed
      )

      "<pre>#{dump}</pre>"
    end

    private

    def redirect_uri
      URI::HTTP.build host: request.host, port: request.port, path: '/oauth2/callback'
    end

    def build_url(path)
      client.connection.build_url(path)
    end

    def client
      Huebot::Auth.client
    end

    run! if app_file == File.expand_path($PROGRAM_NAME)
  end
end
