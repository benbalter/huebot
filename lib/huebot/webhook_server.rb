# frozen_string_literal: true

require 'sinatra/base'
require_relative '../huebot'

class Huebot
  class WebhookServer < Sinatra::Base
    post '/' do
      Huebot.logger.info 'Webhook recieved!'
      Huebot.switcher.switch!
    end

    get '/' do
      redirect 'https://github.com/benbalter/huebot'
    end

    run! if app_file == File.expand_path($PROGRAM_NAME)
  end
end
