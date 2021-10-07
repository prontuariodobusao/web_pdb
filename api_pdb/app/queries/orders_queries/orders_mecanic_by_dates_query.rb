module OrdersQueries
  class OrdersMecanicByDatesQuery
    include QueryBase

    attr_accessor :relation, :end_date, :initial_date

    def initialize(initial_date:, end_date:, relation: Order)
      @relation = relation
      @initial_date = initial_date
      @end_date = end_date
    end

    def call
      start = Date.strptime(initial_date, '%d/%m/%Y')
      end_time = Date.strptime(end_date, '%d/%m/%Y') + 1.day

      OrdersQueries::OrdersByMecanicQuery
        .call
        .where('orders.created_at between ? and ?', start.beginning_of_day, end_time.end_of_day)
    end
  end
end
