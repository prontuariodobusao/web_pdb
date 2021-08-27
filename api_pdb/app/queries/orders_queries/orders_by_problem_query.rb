module OrdersQueries
  class OrdersByProblemQuery
    include QueryBase

    attr_accessor :relation, :order_query

    def initialize(relation: Order, order_query: 'desc')
      @relation = relation
      @order_query = order_query
    end

    def call
      relation
        .select(
          "count(orders.problem_id) as quantity,
 problems.description as name"
        )
        .joins(:problem)
        .group('problems.description')
        .order("quantity #{order_query}")
    end
  end
end
