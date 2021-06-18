module Auth
  # app/services/auth/authenticate_user.rb
  class AuthenticateUser
    def initialize(identity, password)
      @identity = identity
      @password = password
    end

    def call
      ApiPack::JsonWebToken.encode({ user_id: user.id }) if user
    end

    private

    attr_accessor :identity, :password

    def user
      user = User.find_by(identity: identity)
      return user if user&.authenticate(password)

      raise(ApiPack::Errors::Auth::AuthenticationError, 'Invalid credentials')
    end
  end
end
