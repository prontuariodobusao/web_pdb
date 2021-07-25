module Manager
  class OrdersController < ApplicationController
    skip_before_action :ensure_json_content_type, only: :create
    before_action :autorize_manager
    before_action :set_order, only: :show
    before_action :ensure_form_data_content_type, only: :create

    def index
      orders_openeds = Order.to_managers(:opened).order('problems.priority DESC')
      orders_closeds = Order.to_managers(:closed).order('problems.priority DESC')

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

    def autorize_manager
      authorize Order, :manager?
    end

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
        :description,
        :mecanic_id,
        :image
      )
    end
  end
end
