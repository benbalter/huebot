# frozen_string_literal: true

class Huebot
  class AccessToken < OAuth2::AccessToken
    def self.from_hash(client, hash)
      hash = hash.dup
      hash['expires_in'] = hash['access_token_expires_in']
      access_token = hash.delete('access_token') || hash.delete(:access_token)
      new(client, access_token, hash)
    end
  end
end
