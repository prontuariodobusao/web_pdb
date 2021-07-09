class OrdersController < ApplicationController
  skip_before_action :ensure_json_content_type
  before_action :set_order, only: :show

  def index; end

  def show
    links = { image_url: @order.image_url }

    json_response serializer_blueprint(:order, @order, meta: { links: links })
  end

  def create
    order = Order.new order_params
    order.owner = @current_user
    order.save!

    json_response_create(serializer_blueprint(:order, order))
  end

  def update; end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(
      :km,
      :description,
      :vehicle_id,
      :problem_id,
      :vehicle_id,
      :status_id,
      :image
    )
  end
end
