module Vehicles
  class ChangeTime
    include UseCase

    def initialize(method:)
      @method = method
    end

    def call
      change_time
    end

    attr_accessor :method

    private

    def change_time
      vehicles_to_change = vehicles.map do |vehicle|
        next unless send(method, vehicle)[:has_change]

        {
          id: vehicle.id,
          number: vehicle.car_number,
          current_km: vehicle.km,
          next_change: send(method, vehicle)[:next_change]
        }
      end
      vehicles_to_change.compact!
    end

    def vehicles
      Vehicle.all
    end

    def check_oil_change_time(vehicle)
      last_change_order = vehicle.orders.oil_problem.finish.last
      return false if last_change_order.nil?

      next_change = last_change_order.km + OIL_CHANGE
      {
        next_change: next_change,
        has_change: (next_change - vehicle.km) <= GAP_TO_CHANGE
      }
    end

    def check_tire_change_time(vehicle)
      last_change_order = vehicle.orders.tire_problem.finish.last
      return false if last_change_order.nil?

      next_change = last_change_order.km + TIRE_CHANGE
      {
        next_change: next_change,
        has_change: (next_change - vehicle.km) <= GAP_TO_CHANGE
      }
    end

    def check_revision_change_time(vehicle)
      last_change_order = vehicle.orders.revision_problem.finish.last
      return false if last_change_order.nil?

      next_change = last_change_order.km + REVISION_CHANGE
      {
        next_change: next_change,
        has_change: (next_change - vehicle.km) <= GAP_TO_CHANGE
      }
    end
  end
end
