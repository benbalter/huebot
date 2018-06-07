# frozen_string_literal: true

class Huebot
  class Switcher
    include Celluloid
    include Celluloid::Internals::Logger

    def github_status
      Octokit.github_status.status
    end

    def light_id
      @light_id ||= ENV['HUE_LIGHT_ID'].to_i
    end

    def switch!
      status = github_status
      info "Switching light to #{status}"
      Huebot.light_control.set_color light_id, status
    end
  end
end
