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

      order.transaction do
        order.save!
        # create history
        order.histories.create!(history_attr)
      end

      success(order: order)
    end

    def history_attr
      {
        km: order.km,
        description: order.description,
        status: order.status,
        owner: user
      }
    end
  end
end
