class OrdersController < ApplicationController
  before_action :set_order, only: :show
  skip_before_action :ensure_json_content_type, only: :create
  before_action :ensure_form_data_content_type, only: :create

  def index
    orders_openeds = Order.openeds(@current_user)
    orders_closeds = Order.closeds(@current_user)

    json_response(
      {
        openeds: OrderBlueprint.render_as_hash(orders_openeds, view: :list),
        closeds: OrderBlueprint.render_as_hash(orders_closeds, view: :list)
      }
    )
  end

  def show
    json_response OrderBlueprint.render(@order, root: :data, view: :show, meta: { links: links(@order) })
  end

  def create
    order = Orders::CreateOrder.call(user: @current_user, order: Order.new(order_params)).data[:order]

    json_response_create(OrderBlueprint.render(order, root: :data, view: :show, meta: { links: links(order) }),
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
