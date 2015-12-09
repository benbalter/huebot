class Hue
  ENDPOINT = 'https://www.meethue.com/api/sendmessage'

  RED = 0
  YELLOW = 12750
  DEFAULT_STATE = {
    on: true,
    bri: 254,
    alert: 'none',
    sat: 255
  }

  attr_reader :bridge_id, :access_token

  def initialize(options={})
    @bridge_id    = options[:bridge_id]
    @access_token = options[:access_token]
  end

  def set_color(light, status)
    case status
    when "good"
      state = DEFAULT_STATE.merge({ sat: 0 })
    when "minor"
      state = DEFAULT_STATE.merge({ hue: YELLOW, alert: "lselect" })
    when "major"
      state = DEFAULT_STATE.merge({ hue: RED, alert: "lselect" })
    end

    send light, state
  end

  private

  def send(light, state)
    url = "#{ENDPOINT}?token=#{access_token}"

    command = {
      url: "/api/0/lights/#{light}/state",
      method: "PUT",
      body: state
    }

    response = Typhoeus.post url, {
      :headers  => { 'Content-Type' => 'application/x-www-form-urlencoded' },
      :body     => clip_message(command)
    }
    response.success?
  end

  def clip_message(command)
   command = command.map { |k,v| "#{k}: #{v.to_json}"}.join(", ")
   "clipmessage={ bridgeId: \"#{bridge_id}\", clipCommand: { #{command} } }"
  end
end
