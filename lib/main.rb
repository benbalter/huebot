require 'tweetstream'
require 'dotenv'
require 'celluloid'
require 'typhoeus'
require 'octokit'
require 'json'
require_relative 'hue'
require_relative 'switcher'

Dotenv.load

TweetStream.configure do |config|
  config.consumer_key       = ENV.fetch 'TWITTER_CONSUMER_KEY'
  config.consumer_secret    = ENV.fetch 'TWITTER_CONSUMER_SECRET'
  config.oauth_token        = ENV.fetch 'TWITTER_OAUTH_TOKEN'
  config.oauth_token_secret = ENV.fetch 'TWITTER_OAUTH_TOKEN_SECRET'
  config.auth_method        = :oauth
end

twitter_id = ENV.fetch "TWITTER_ID", "2293448130"
TweetStream::Client.new.follow(twitter_id) do |tweet|
  Logger.new(STDOUT).info "We've got a new tweet!"
  Switcher.new.async.switch!
end
