module Auth
  class Authenticate
    include UseCase

    def initialize(identity:, password:)
      @identity = identity
      @password = password
    end

    def call
      auth if find_user
    end

    private

    attr_accessor :identity, :password

    def auth
      success(
        token: ApiPack::JsonWebToken.encode(
          {
            user_id: find_user.id,
            name: find_user.name,
            confirmation: find_user.confirmed?
          }
        )
      )
    end

    def find_user
      user = User.find_by(identity: identity)
      return user if user&.unlocked? && user&.authenticate(password)

      raise(ApiPack::Errors::Auth::AuthenticationError, 'Usuário ou senha inválidos!')
    end
  end
end
