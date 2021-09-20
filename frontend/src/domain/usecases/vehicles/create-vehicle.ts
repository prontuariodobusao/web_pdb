import {VehicleDataModel} from '../../models/vehicle-model'

export type VehicleParams = {
  data: {
    car_number: string
    km: number
    car_line_id: number
    oil_date: string
    tire_date: string
    revision_date: string
  }
}

export interface CreateVehicle {
  create: (params: VehicleParams) => Promise<VehicleDataModel>
}
