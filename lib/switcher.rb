class Switcher
  include Celluloid
  include Celluloid::Internals::Logger

  LIGHT = 3

  def github_status
    Octokit.github_status.status
  end

  def hue
    @hue ||= Hue.new bridge_id: ENV["HUE_BRIDGE_ID"], access_token: ENV["HUE_ACCESS_TOKEN"]
  end

  def switch!
    status = github_status
    info "Switching light to #{status}"
    hue.set_color LIGHT, status
  end
end
