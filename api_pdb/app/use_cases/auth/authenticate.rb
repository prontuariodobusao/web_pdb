module Auth
  class Authenticate
    include UseCase

    def initialize(identity:, password:)
      @identity = identity
      @password = password
    end

    def call
      auth if user
    end

    private

    attr_accessor :identity, :password

    def auth
      success(token: ApiPack::JsonWebToken.encode({ user_id: user.id }))
    end

    def user
      user = User.find_by(identity: identity)
      return user if user&.authenticate(password)

      raise(ApiPack::Errors::Auth::AuthenticationError, 'Invalid credentials')
    end
  end
end
