module OrdersQueries
  class OrdersByProblemsMecanicQuery
    include QueryBase

    attr_accessor :relation, :order_query, :mecanic_id

    def initialize(mecanic_id:, relation: Order, order_query: 'desc')
      @relation = relation
      @order_query = order_query
      @mecanic_id = mecanic_id
    end

    def call
      relation
        .select("
          count(orders.problem_id) as quantity,
          problems.description as name
        ")
        .joins(:problem, :car_mecanic)
        .by_mecanic(mecanic_id)
        .group('problems.description')
        .order("quantity #{order_query}")
    end
  end
end
