module OrdersQueries
  class OrdersByProblemsDriverQuery
    include QueryBase

    attr_accessor :relation, :order_query, :driver_id

    def initialize(driver_id:, relation: Order, order_query: 'desc')
      @relation = relation
      @order_query = order_query
      @driver_id = driver_id
    end

    def call
      relation
        .select("
          count(orders.problem_id) as quantity,
          problems.description as name
        ")
        .joins(:problem, owner: :employee)
        .where('employees.occupation_id = 1')
        .where('employees.id = ?', driver_id)
        .group('problems.description')
        .order("quantity #{order_query}")
    end
  end
end
