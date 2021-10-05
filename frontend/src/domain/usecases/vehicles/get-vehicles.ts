import {VehicleDataModel} from '../../models/vehicle-model'

export interface GetVehicle {
  get: () => Promise<VehicleDataModel>
}
