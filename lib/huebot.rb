# frozen_string_literal: true

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'sinatra/base'
require 'oauth2'
require 'json'
require 'dotenv/load'
require 'redis'
require 'twitter'
require 'celluloid'
require 'octokit'

class Huebot
  autoload :Auth,         'huebot/auth'
  autoload :AuthServer,   'huebot/auth_server'
  autoload :AccessToken,  'huebot/access_token'
  autoload :Client,       'huebot/client'
  autoload :LightControl, 'huebot/light_control'
  autoload :Streamer,     'huebot/streamer'
  autoload :Switcher,     'huebot/switcher'
  autoload :Version,      'hubot/version'

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

    def streamer
      @streamer ||= Streamer.new
    end

    def switcher
      @switcher ||= Switcher.new
    end
  end
end
