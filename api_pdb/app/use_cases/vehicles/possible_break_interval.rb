module Vehicles
  class PossibleBreakInterval
    include UseCase

    def initialize(vehicle:)
      @vehicle = vehicle
    end

    def call
      possible_break_interval
    end

    attr_accessor :vehicle

    private

    def possible_break_interval
      orders = vehicle.orders.where.not(problem_id: [1, 2, 3]).order(:created_at)

      return 'N/I' if orders.empty? || orders.count == 1

      dates = orders.map { |order| order.created_at.to_date }
      intervals = dates.each_with_index.map { |_val, index| (dates[index + 1] - dates[index]).to_i unless dates[index + 1].nil? }.compact!

      interval = intervals.sum / intervals.count

      orders.last.created_at.to_date + interval.days
    end
  end
end
