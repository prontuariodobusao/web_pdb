module Auth
  # app/services/auth/authenticate_user.rb
  class AuthenticateUser
    def initialize(cpf, password)
      @cpf = cpf
      @password = password
    end

    def call
      ApiPack::JsonWebToken.encode({ user_id: user.id }) if user
    end

    private

    attr_accessor :cpf, :password

    def user
      user = User.find_by(cpf: cpf)
      return user if user&.authenticate(password)

      raise(ApiPack::Errors::Auth::AuthenticationError, 'Invalid credentials')
    end
  end
end
