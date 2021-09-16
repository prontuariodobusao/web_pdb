module OrdersQueries
  class OrdersHistoriesByStatusQuery
    include QueryBase

    attr_accessor :relation, :status

    def initialize(status:, relation: Order)
      @relation = relation
      @status = status
    end

    def call
      relation
        .select('orders.id, orders.reference, histories.created_at, histories.status_id')
        .finish
        .joins(:histories)
        .where('histories.status_id = ?', status)
        .order(:id)
    end
  end
end
