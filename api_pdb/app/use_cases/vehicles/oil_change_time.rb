module Vehicles
  class OilChangeTime
    include UseCase

    def call
      oil_change_time
    end

    private

    def oil_change_time
      vehicles_to_oil_change = vehicles.map do |vehicle|
        next unless check_oil_change_time(vehicle)

        {
          car_number: vehicle.car_number,
          current_km: vehicle.km
        }
      end
      vehicles_to_oil_change.compact!
    end

    def vehicles
      Vehicle.all
    end

    def check_oil_change_time(vehicle)
      last_change_order = vehicle.orders.oil_problem.last
      return false if last_change_order.nil?

      next_change = last_change_order.km + 15_000
      (next_change - vehicle.km) <= 3_000
    end
  end
end
