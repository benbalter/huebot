class Huebot
  class Client < OAuth2::Client
    # Initializes an AccessToken by making a request to the token endpoint
    #
    # @param [Hash] params a Hash of params for the token endpoint
    # @param [Hash] access token options, to pass to the AccessToken object
    # @param [Class] class of access token for easier subclassing OAuth2::AccessToken
    # @return [AccessToken] the initialized AccessToken
    def get_token(params, access_token_opts = {}, access_token_class = AccessToken) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      params = authenticator.apply(params)
      opts = { raise_errors: options[:raise_errors], parse: params.delete(:parse) }
      headers = params.delete(:headers) || {}
      if options[:token_method] == :post
        opts[:body] = URI.encode_www_form(params)
        opts[:headers] = { 'Content-Type' => 'application/x-www-form-urlencoded' }
      else
        opts[:params] = params
        opts[:headers] = {}
      end
      opts[:headers].merge!(headers)

      # Begin edits from original
      if params[:grant_type] == 'refresh_token'
        params = { 'grant_type' => params[:grant_type] }
        response = request(options[:token_method], refresh_url(params), opts)
      else
        response = request(options[:token_method], token_url, opts)
      end
      # End edits from original

      if options[:raise_errors] && !(response.parsed.is_a?(Hash) && response.parsed['access_token'])
        error = Error.new(response)
        raise(error)
      end
      build_access_token(response, access_token_opts, access_token_class)
    end

    # The token endpoint URL of the OAuth2 provider
    #
    # @param [Hash] params additional query parameters
    def refresh_url(params = nil)
      connection.build_url(options[:refresh_url], params).to_s
    end
  end
end
