# frozen_string_literal: true

class Huebot
  class Streamer
    USER_ID = 2_293_448_130

    def stream
      log 'Started streaming'
      client.filter(follow: USER_ID) do |_tweet|
        log "We've got a Tweet!"
        Huebot.switcher.switch!
      end
    end

    private

    def log(msg)
      Huebot.logger.info msg
    end

    def client
      @client ||= Twitter::Streaming::Client.new do |config|
        config.consumer_key        = ENV.fetch 'TWITTER_CONSUMER_KEY'
        config.consumer_secret     = ENV.fetch 'TWITTER_CONSUMER_SECRET'
        config.access_token        = ENV.fetch 'TWITTER_OAUTH_TOKEN'
        config.access_token_secret = ENV.fetch 'TWITTER_OAUTH_TOKEN_SECRET'
      end
    end
  end
end
