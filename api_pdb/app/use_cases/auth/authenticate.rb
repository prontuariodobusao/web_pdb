module Auth
  class Authenticate
    include UseCase

    def initialize(username:, password:)
      @username = username
      @password = password
    end

    def call
      auth if find_user
    end

    private

    attr_accessor :username, :password

    def auth
      success(
        token: ApiPack::JsonWebToken.encode(
          {
            user_id: find_user.id,
            name: find_user.employee_name,
            confirmation: find_user.confirmed?,
            occupation: find_user.employee.occupation_type_occupation
          }
        )
      )
    end

    def find_user
      user = User.find_by(username: username)
      return user if user&.unlocked? && user&.authenticate(password)

      raise(ApiPack::Errors::Auth::AuthenticationError, 'Usuário ou senha inválidos!')
    end
  end
end
