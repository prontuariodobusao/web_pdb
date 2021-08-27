module OrdersQueries
  class OrdersByStatusQuery
    include QueryBase

    attr_accessor :relation, :order_query

    def initialize(relation: Order, order_query: 'asc')
      @relation = relation
      @order_query = order_query
    end

    def call
      relation
        .select("count(statuses.id) as quantity,
                   statuses.name as name")
        .joins(:status)
        .group('statuses.name')
        .order("quantity #{order_query}")
    end
  end
end
