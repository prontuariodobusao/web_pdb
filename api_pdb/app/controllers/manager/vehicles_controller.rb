module Manager
  class VehiclesController < ApplicationController
    before_action :set_vehicle, only: %i[update show]
    before_action :autorize_manager_or_rh

    def datatable
      vehicles = Vehicle.includes(:car_line).order(:car_number)
      result_dt = datatable_render(vehicles, params, field_search: 'car_number')
      json_response({ draw: params[:draw],
                      totalRecords: result_dt[:totalRecords],
                      data: VehicleBlueprint.render_as_hash(result_dt[:result]) })
    end

    # POST /manager/vehicles
    def create
      vehicle = Vehicle.new(vehicle_params)
      vehicle.save!
      json_response(VehicleBlueprint.render_as_hash(vehicle, root: :data, meta: { links: links(vehicle) }), :created)
    end

    # PATCH/PUT /manager/vehicles/1
    def update
      @vehicle.update!(vehicle_params)
      json_response VehicleBlueprint.render(@vehicle, root: :data, meta: { links: links(@vehicle) })
    end

    def show
      json_response VehicleBlueprint.render(@vehicle, root: :data, meta: { links: links(@vehicle) })
    end

    def revisions
      vehicles_to_oil_change = Vehicles::ChangeTime.call(method: :check_oil_change_time)
      vehicles_to_tire_change = Vehicles::ChangeTime.call(method: :check_tire_change_time)
      vehicles_to_revision_change = Vehicles::ChangeTime.call(method: :check_revision_change_time)

      json_response({
                      vehicles_to_oil_change: vehicles_to_oil_change,
                      vehicles_to_tire_change: vehicles_to_tire_change,
                      vehicles_to_revision_change: vehicles_to_revision_change
                    })
    end

    private

    def autorize_manager_or_rh
      authorize Employee, :admin_or_rh?
    end

    def links(vehicle)
      { self: manager_vehicle_url(vehicle) }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:data).permit(
        :car_number,
        :km,
        :car_line_id,
        :oil_date,
        :tire_date,
        :revision_date
      )
    end
  end
end
