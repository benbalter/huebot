# frozen_string_literal: true

class Huebot
  class LightControl
    RED = 0
    YELLOW = 12_750
    DEFAULT_STATE = {
      on: true,
      bri: 254,
      alert: 'none',
      sat: 255
    }.freeze
    REQUEST_OPTIONS = {
      headers: {
        'Content-Type' => 'application/json'
      }
    }.freeze

    def set_color(light, status)
      case status
      when 'good'
        state = DEFAULT_STATE.merge(sat: 0)
      when 'minor'
        state = DEFAULT_STATE.merge(hue: YELLOW, alert: 'lselect')
      when 'major'
        state = DEFAULT_STATE.merge(hue: RED, alert: 'lselect')
      end

      set_state light, state
    end

    private

    def build_url(path)
      token.client.connection.build_url "/bridge/#{username}/#{path}"
    end

    def set_state(light, state)
      options = REQUEST_OPTIONS.merge(body: state.to_json)
      token.put build_url("lights/#{light}/state"), options
    end

    def token
      Huebot::Auth.token
    end

    def username
      @username ||= Huebot.redis.get 'username'
    end
  end
end
