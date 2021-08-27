module OrdersQueries
  class OrdersByCategoryQuery
    include QueryBase

    attr_accessor :relation, :order_query

    def initialize(relation: Order, order_query: 'asc')
      @relation = relation
      @order_query = order_query
    end

    def call
      relation
        .select("count(problems.category_id) as quantity,
                   categories.name as name")
        .joins(problem: :category)
        .group('categories.name')
        .order("quantity #{order_query}")
    end
  end
end
