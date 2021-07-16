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
      reference = "P#{(0..4).map { rand(1..5) }.join}/#{Date.current.strftime('%Y')}"
      order.reference = reference
      order.owner = user

      order.save!

      success(order: order)
    end
  end
end
