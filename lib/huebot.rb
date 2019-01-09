# frozen_string_literal: true

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sinatra/base'
require 'oauth2'
require 'json'
require 'dotenv/load'
require 'redis'
require 'twitter'
require 'octokit'

class Huebot
  autoload :Auth,          'huebot/auth'
  autoload :AuthServer,    'huebot/auth_server'
  autoload :AccessToken,   'huebot/access_token'
  autoload :Client,        'huebot/client'
  autoload :LightControl,  'huebot/light_control'
  autoload :Switcher,      'huebot/switcher'
  autoload :Version,       'huebot/version'
  autoload :WebhookServer, 'huebot/webhook_server'

  class << self
    def redis
      @redis ||= Redis.new(url: ENV['REDIS_URL'])
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def light_control
      @light_control ||= LightControl.new
    end

    def switcher
      @switcher ||= Switcher.new
    end
  end
end
