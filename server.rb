require 'sinatra'
require 'octokit'
require 'dotenv'
require 'typhoeus'
require 'json'

Dotenv.load

COLORS = {
  "good"  => "#FFFFFF",
  "minor" => "#FFFF00",
  "major" => "#FF0000"
}

EVENT_NAME = "github_status_change"

def endpoint
  "https://maker.ifttt.com/trigger/#{EVENT_NAME}/with/key/#{ENV["IFTTT_MAKER_KEY"]}"
end

get "/"
  "It works!"
end

post '/ping' do
  status = Octokit.github_status.status
  body = { "value1" => COLORS[status] }
  Typhoeus.post endpoint, body: body
end
