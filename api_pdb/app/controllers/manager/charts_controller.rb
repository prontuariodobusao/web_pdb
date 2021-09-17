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
                        os_finish: Order.finish.count,
                        os_down_time: Orders::DownTime.call
                      },
                      categories: categories,
                      problems: problems
                    })
    end

    def report_by_dates
      reports = Order.query_by_dates(
        dates_params[:initial_date],
        dates_params[:end_date],
        dates_params[:type_report]
      ).map do |report|
        {
          name: report.name,
          y: report.quantity
        }
      end

      json_response({ report: reports })
    end

    def report_mecanic_by_dates
      orders_maintenance = Order.query_mecanic_by_dates(dates_params[:initial_date], dates_params[:end_date])
                                .maintenance
                                .map do |report|
        {
          name: report.name,
          y: report.quantity
        }
      end

      orders_finish = Order.query_mecanic_by_dates(dates_params[:initial_date], dates_params[:end_date])
                           .finish
                           .map do |report|
        {
          name: report.name,
          y: report.quantity
        }
      end

      json_response({ orders_maintenance: orders_maintenance, orders_finish: orders_finish })
    end

    def report_employee_problems_by_dates
      reports = Order.query_employee_problems_by_dates(
        dates_params[:initial_date],
        dates_params[:end_date],
        dates_params[:employee_id],
        dates_params[:employee_type]
      ).map do |report|
        {
          name: report.name,
          y: report.quantity
        }
      end

      json_response({ report: reports })
    end
  
    private

    def dates_params
      params.require(:data).permit(:type_report, :initial_date, :end_date, :employee_id, :employee_type)
    end

    def autorize_manager_or_rh
      authorize Employee, :admin_or_rh?
    end
  end
end
