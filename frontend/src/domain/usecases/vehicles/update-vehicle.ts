import {VehicleDataModel} from '../../models/vehicle-model'

export type VehicleUpateParams = {
  data: {
    car_number: string
    km: number
    car_line_id: number
    oil_date: string
    tire_date: string
    revision_date: string
  }
}

export interface UpdateVehicle {
  update: (params: VehicleUpateParams) => Promise<VehicleDataModel>
}
