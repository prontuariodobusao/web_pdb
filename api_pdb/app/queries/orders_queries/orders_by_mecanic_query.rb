module OrdersQueries
  class OrdersByMecanicQuery
    include QueryBase

    attr_accessor :relation, :order_query, :status

    def initialize(relation: Order, order_query: 'asc')
      @relation = relation
      @order_query = order_query
    end

    def call
      relation
        .select("count(employees.id) as quantity,
        employees.name as name")
        .joins(:car_mecanic)
        .group('employees.name')
        .order("quantity #{order_query}")
    end
  end
end
