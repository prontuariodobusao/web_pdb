class OrdersController < ApplicationController
  before_action :set_order, only: :show
  skip_before_action :ensure_json_content_type, only: :create
  before_action :ensure_form_data_content_type, only: :create

  def index
    orders = Order.where(owner: @current_user)

    json_response OrderBlueprint.render(orders)
  end

  def show
    json_response serializer_blueprint(:order, @order, meta: { links: links(@order) })
  end

  def create
    order = Order.new order_params
    order.owner = @current_user

    order.save!

    json_response_create(serializer_blueprint(:order, order, meta: { links: links(order) }),
                         order_path(order))
  end

  def update; end

  private

  def links(order)
    { self: order_url(order), image_url: order.image_url }
  end

  def ensure_form_data_content_type
    return if request.get? || request.headers['Content-Type'] =~ /form-data/

    render body: nil, status: 415
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:data).permit(
      :km,
      :vehicle_id,
      :problem_id,
      :status_id,
      :image
    )
  end
end
