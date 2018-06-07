# frozen_string_literal: true

class Huebot
  class Auth
    OPTIONS = {
      site: 'https://api.meethue.com/',
      authorize_url: '/oauth2/auth',
      token_url: '/oauth2/token',
      refresh_url: '/oauth2/refresh'
    }.freeze
    APP_ID = 'c88b5ca3-088f-4780-9136-672d2162de39'
    DEVICE_ID = 'Huebot'

    class << self
      attr_writer :token

      def client
        @client ||= Huebot::Client.new(client_id, client_secret, OPTIONS)
      end

      def token(code = nil)
        if code
          params = { 'grant_type' => 'authorization_code', 'code' => code }.merge(client.redirection_params)
          @token = client.get_token(params, {}, Huebot::AccessToken)
        else
          @token ||= begin
            hash = Huebot.redis.get 'token'
            Huebot::AccessToken.from_hash(client, JSON.parse(hash)) if hash
          end
        end
      end

      def refresh
        new_token = token.refresh
        Huebot.redis.set 'token', new_token.to_hash.to_json
        @token = new_token
      end

      private

      def client_id
        ENV['HUE_CLIENT_ID']
      end

      def client_secret
        ENV['HUE_CLIENT_SECRET']
      end
    end
  end
end
