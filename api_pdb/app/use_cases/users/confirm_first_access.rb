module Users
  class ConfirmFirstAccess
    include UseCase

    def initialize(user:, attributes:)
      @user = user
      @password = attributes[:password]
      @password_confirmation = attributes[:password_confirmation]
    end

    def call
      unlock
    end

    private

    attr_accessor :user, :password, :password_confirmation

    def unlock
      user.update!(password: password, password_confirmation: password_confirmation, confirmed_at: DateTime.current)

      success(user: user)
    end
  end
end
