module Manager
  class OrdersController < ApplicationController
    skip_before_action :ensure_json_content_type, only: :update
    before_action :autorize_manager
    before_action :set_order, only: %i[show update edit]
    before_action :ensure_form_data_content_type, only: :update

    def edit
      solutions = Solution.select(:id, :description).where(problem: @order.problem)
      statuses = Orders::StatusFlow.call(current_status: @order.status_id)
      mecanics = Employee.select(:id, :name).joins(:occupation).where('occupations.type_occupation = 1')

      json_response(
        {
          solutions: solutions,
          statuses: statuses,
          mecanics: mecanics
        }
      )
    end

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

    def update
      @order.manager = current_user.employee
      @order.update!(order_params_update)

      head :no_content
    end

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

    def order_params_update
      params.require(:data).permit(
        :km,
        :vehicle_id,
        :problem_id,
        :status_id,
        :description,
        :car_mecanic_id,
        :image
      )
    end
  end
end
