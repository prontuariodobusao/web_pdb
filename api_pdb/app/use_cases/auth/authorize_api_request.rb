module Auth
  # app/services/auth/authorize_api_request.rb
  class AuthorizeApiRequest
    include UseCase

    def initialize(headers: {})
      @headers = headers
    end

    def call
      find_user if decoded_auth_token
    end

    private

    attr_accessor :headers

    def find_user
      success(user: User.find(decoded_auth_token['user_id']))
    rescue ActiveRecord::RecordNotFound => e
      raise ApiPack::Errors::Auth::InvalidToken, ("Invalid token #{e.message}")
    end

    def decoded_auth_token
      ApiPack::JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      return headers['Authorization'].split.last if headers['Authorization'].present?

      raise(ApiPack::Errors::Auth::MissingToken, 'Missing token')
    end
  end
end
