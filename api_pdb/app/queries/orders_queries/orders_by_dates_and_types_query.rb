module OrdersQueries
  class OrdersByDatesAndTypesQuery
    include QueryBase

    attr_accessor :relation, :type_report, :end_date, :initial_date

    def initialize(initial_date:, end_date:, type_report:, relation: Order)
      @relation = relation
      @initial_date = initial_date
      @end_date = end_date
      @type_report = type_report
    end

    def call
      start = Date.strptime(initial_date, '%d/%m/%Y')
      end_time = Date.strptime(end_date, '%d/%m/%Y') + 1.day

      case type_report
      when 1
        OrdersQueries::OrdersByCategoryQuery.call.where('orders.created_at between ? and ?', start, end_time)
      when 2
        OrdersQueries::OrdersByProblemQuery.call.where('orders.created_at between ? and ?', start, end_time)
      when 3
        OrdersQueries::OrdersByStatusQuery.call.where('orders.created_at between ? and ?', start, end_time)
      when 4
        OrdersQueries::OrdersByMecanicQuery.call.where('orders.created_at between ? and ?', start, end_time)
      end
    end
  end
end
