import {DataTableParams} from '../../domain/usecases/remote-datatable'
import {VehicleDataModel} from '../../domain/models/vehicle-model'

export const mockVehicleDataModel = (): VehicleDataModel => ({
  data: {
    id: 1,
    car_line_id: 1,
    km: 123,
    car_number: '1234',
    oil_date: '01/01/2020',
    tire_date: '01/01/2020',
    revision_date: '01/01/2020',
  },
  meta: {
    links: {
      self: 'url',
    },
  },
})

export const mockVehicleDataTableParams = (): DataTableParams => {
  return {
    draw: 1,
    page: 1,
    per_page: 10,
    sort_field: null,
    sort_direction: 'asc',
    search_value: '',
  }
}
