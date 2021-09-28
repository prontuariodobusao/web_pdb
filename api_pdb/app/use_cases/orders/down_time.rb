module Orders
  class DownTime
    include UseCase

    def call
      down_time
    end

    private

    def down_time
      orders_history_finish = OrdersQueries::OrdersHistoriesByStatusQuery.call(status: 4)

      down_times = orders_history_finish.map do |order_history_finish|
        history_maintenance = order_history_finish.histories.where('histories.status_id = 2').take
        days = (order_history_finish.created_at.to_date - history_maintenance.created_at.to_date).to_i

        next 1 if days <= 0

        days
      end
      (down_times.sum.to_f / down_times.count).ceil
    end
  end
end
