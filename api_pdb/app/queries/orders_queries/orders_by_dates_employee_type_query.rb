module OrdersQueries
  class OrdersByDatesEmployeeTypeQuery
    include QueryBase

    attr_accessor :relation, :employee_type, :employee_id, :end_date, :initial_date

    def initialize(initial_date:, end_date:, employee_type:, employee_id:, relation: Order)
      @relation = relation
      @initial_date = initial_date
      @end_date = end_date
      @employee_type = employee_type
      @employee_id = employee_id
    end

    def call
      start = Date.strptime(initial_date, '%d/%m/%Y')
      end_time = Date.strptime(end_date, '%d/%m/%Y')

      case employee_type
      when 'driver'
        OrdersQueries::OrdersByProblemsDriverQuery
          .call(driver_id: employee_id)
          .where('orders.created_at between ? and ?', start.beginning_of_day, end_time.end_of_day)
      when 'mecanic'
        OrdersQueries::OrdersByProblemsMecanicQuery
          .call(mecanic_id: employee_id)
          .where('orders.created_at between ? and ?', start.beginning_of_day, end_time.end_of_day)
      end
    end
  end
end
