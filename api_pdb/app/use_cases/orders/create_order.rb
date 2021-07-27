module Orders
  class CreateOrder
    include UseCase

    def initialize(user:, order:)
      @user = user
      @order = order
    end

    def call
      create
    end

    private

    attr_accessor :user, :order

    def create
      order.reference = Orders::NextNumber.call
      order.owner = user

      order.save!

      success(order: order)
    end
  end
end
