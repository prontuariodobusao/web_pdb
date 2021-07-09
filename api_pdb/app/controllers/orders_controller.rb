class OrdersController < ApplicationController
  skip_before_action :ensure_json_content_type, only: :create
  before_action :set_order, only: :show

  def index
    orders = Order.where(owner: @current_user)

    json_response serializer_blueprint(:order, orders)
  end

  def show
    links = { image_url: @order.image_url }

    json_response serializer_blueprint(:order, @order, meta: { links: links })
  end

  def create
    order = Order.new order_params
    order.owner = @current_user
    order.status_id = 1

    order.save!

    json_response_create(serializer_blueprint(:order, order, meta: { links: { self: order_url(order) } }),
                         order_path(order))
  end

  def update; end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:data).permit(
      :km,
      :vehicle_id,
      :problem_id,
      :image
    )
  end
end
