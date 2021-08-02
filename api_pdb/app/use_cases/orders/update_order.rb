module Orders
  class UpdateOrder
    include UseCase

    def initialize(user:, order:, order_params:)
      @user = user
      @order = order
      @order_params = order_params
    end

    def call
      update_order
    end

    private

    attr_accessor :user, :order, :order_params

    def update_order
      order.manager = user.employee
      order.state = :closed if finish?

      order.update!(order_params)

      success(order: order)
    end

    def finish?
      order_params[:status_id].to_i == 3 || order_params[:status_id].to_i == 4
    end
  end
end
