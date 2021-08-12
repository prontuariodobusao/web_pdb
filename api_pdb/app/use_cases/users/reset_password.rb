module Users
  class ResetPassword
    include UseCase

    def initialize(user:)
      @user = user
      @password = "#{SecureRandom.alphanumeric(5).downcase}3"
    end

    def call
      reset_password
    end

    private

    attr_accessor :user, :password

    def reset_password
      user.update!(password: password, password_confirmation: password, locked_at: nil, confirmed_at: nil)

      success({ user: user, password: password })
    end
  end
end
