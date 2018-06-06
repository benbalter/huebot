class Switcher
  include Celluloid
  include Celluloid::Internals::Logger

  def github_status
    Octokit.github_status.status
  end

  def hue
    @hue ||= Hue.new bridge_id: ENV['HUE_BRIDGE_ID'], access_token: ENV['HUE_ACCESS_TOKEN']
  end

  def switch!
    status = github_status
    info "Switching light to #{status}"
    hue.set_color ENV['HUE_LIGHT_ID'].to_i, status
  end
end
