module Manager
  class ChartsController < ApplicationController
    before_action :autorize_manager_or_visitor
    before_action :date_range_for_weekly_charts, only: :report

    def report
      categories = Order.by_categories
                        .by_dates(@start_date, @end_date)
                        .map do |status|
        {
          name: status.name,
          y: status.quantity
        }
      end

      problems = Order
                 .by_problems
                 .by_dates(@start_date, @end_date)
                 .limit(10)
                 .map do |problem|
        {
          name: problem.name,
          y: problem.quantity
        }
      end
      vehicles_to_oil_change = Vehicles::ChangeTime.call(method: :check_oil_change_time)
      vehicles_to_tire_change = Vehicles::ChangeTime.call(method: :check_tire_change_time)
      vehicles_to_revision_change = Vehicles::ChangeTime.call(method: :check_revision_change_time)

      json_response({
                      qtds: {
                        total: Order.by_dates(@start_date, @end_date).count,
                        os_waiting: Order.by_dates(@start_date, @end_date).waiting.count,
                        os_maintenance: Order.by_dates(@start_date, @end_date).maintenance.count,
                        os_canceled: Order.by_dates(@start_date, @end_date).canceled.count,
                        os_finish: Order.by_dates(@start_date, @end_date).finish.count,
                        os_down_time: Orders::DownTime.call,
                        vehicles_to_oil_change: vehicles_to_oil_change.count,
                        vehicles_to_tire_change: vehicles_to_tire_change.count,
                        vehicles_to_revision_change: vehicles_to_revision_change.count
                      },
                      categories: categories,
                      problems: problems,
                      vehicles_to_oil_change: vehicles_to_oil_change,
                      vehicles_to_tire_change: vehicles_to_tire_change,
                      vehicles_to_revision_change: vehicles_to_revision_change
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
      )
                     .maintenance_and_finish
                     .map do |report|
        {
          name: report.name,
          y: report.quantity
        }
      end

      json_response({ report: reports })
    end

    private

    def date_range_for_weekly_charts
      current_date = Date.current
      @start_date = current_date.beginning_of_week
      @end_date = current_date.end_of_day
    end

    def dates_params
      params.require(:data).permit(:type_report, :initial_date, :end_date, :employee_id, :employee_type)
    end

    def autorize_manager_or_visitor
      authorize Employee, :admin_or_visitor?
    end
  end
end
