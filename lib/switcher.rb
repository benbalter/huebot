class Switcher
  include Celluloid
  include Celluloid::Internals::Logger

  EVENT_NAME = "github_status_change"
  COLORS = {
    "good"  => "#FFFFFF",
    "minor" => "#FFFF00",
    "major" => "#FF0000"
  }

  def github_status
    Octokit.github_status.status
  end

  def endpoint
    "https://maker.ifttt.com/trigger/#{EVENT_NAME}/with/key/#{ENV["IFTTT_MAKER_KEY"]}"
  end

  def switch!
    status = github_status
    body = { "value1" => COLORS[status] }
    
    info "Switching light to #{status}"
    Typhoeus.post endpoint, body: body
  end
end
