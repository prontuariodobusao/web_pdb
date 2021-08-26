module Manager
  class ChartsController < ApplicationController
    before_action :autorize_manager_or_rh

    def report
      categories = Order
                   .select("count(problems.category_id) as quantity,
                   categories.name as name")
                   .joins(problem: :category)
                   .group('categories.name')
                   .order('quantity asc')
                   .map do |status|
        {
          name: status.name,
          y: status.quantity
        }
      end

      problems = Order
                 .select(
                   "count(orders.problem_id) as quantity,
            problems.description as name"
                 )
                 .joins(:problem)
                 .group('problems.description')
                 .order('quantity desc')
                 .limit(10)
                 .map do |problem|
        {
          name: problem.name,
          y: problem.quantity
        }
      end

      json_response({
                      qtds: {
                        total: Order.count,
                        os_waiting: Order.waiting.count,
                        os_maintenance: Order.maintenance.count,
                        os_canceled: Order.canceled.count,
                        os_finish: Order.finish.count
                      },
                      categories: categories,
                      problems: problems
                    })
    end

    private

    def autorize_manager_or_rh
      authorize Employee, :admin_or_rh?
    end
  end
end
