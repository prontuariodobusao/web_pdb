module Manager
  class OrdersController < ApplicationController
    skip_before_action :ensure_json_content_type, only: :update
    before_action :autorize_manager
    before_action :set_order, only: %i[show update edit]
    before_action :ensure_form_data_content_type, only: :update

    def edit
      solutions = Solution.select(:id, :description).where(problem: @order.problem)
      statuses = Orders::StatusFlow.call(current_status: @order.status_id)
      mecanics = Employee.select(:id, :name).joins(:occupation).where('occupations.type_occupation = 3')

      json_response(
        {
          solutions: solutions,
          statuses: statuses,
          mecanics: mecanics
        }
      )
    end

    def panel
      orders = Order.includes(:car_mecanic, :owner, :status, problem: :category).maintenance
      json_response OrderBlueprint.render(orders, root: :data, view: :panel)
    end

    def index
      orders_openeds = Order.to_managers(:opened).order('problems.priority ASC', reference: :desc)
      orders_closeds = Order.to_managers(:closed).order('problems.priority ASC', reference: :desc)

      json_response(
        {
          openeds: OrderBlueprint.render_as_hash(orders_openeds, view: :list),
          closeds: OrderBlueprint.render_as_hash(orders_closeds, view: :list)
        }
      )
    end

    def show
      json_response OrderBlueprint.render(@order, root: :data, view: :show_manager, meta: { links: links(@order) })
    end

    def update
      Orders::UpdateOrder.call(user: current_user, order: @order, order_params: order_params_update)
      head :no_content
    end

    private

    def autorize_manager
      authorize Order, :admin?
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

    def order_params_update
      params.require(:data).permit(
        :status_id,
        :description,
        :car_mecanic_id,
        :solution_id
      )
    end
  end
end
