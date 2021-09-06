module Manager
  class ChartsController < ApplicationController
    before_action :autorize_manager_or_rh

    def report
      categories = Order.by_categories
                        .map do |status|
        {
          name: status.name,
          y: status.quantity
        }
      end

      problems = Order
                 .by_problems
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

    def report_by_dates
      report = Order.query_by_dates(dates_params[:initial_date], dates_params[:end_date],
                                    dates_params[:type_report]).map do |problem|
        {
          name: problem.name,
          y: problem.quantity
        }
      end
      json_response({ report: report })
    end

    private

    def dates_params
      params.require(:data).permit(:type_report, :initial_date, :end_date)
    end

    def autorize_manager_or_rh
      authorize Employee, :admin_or_rh?
    end
  end
end
