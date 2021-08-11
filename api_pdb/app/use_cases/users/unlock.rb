module Users
  class Unlock 
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
      user.update!(password: password, password_confirmation: password_confirmation, locked_at: nil, confirmed_at: nil)

      success(user: user)
    end
  end
end
