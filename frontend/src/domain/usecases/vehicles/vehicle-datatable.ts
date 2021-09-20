import {
  DataTableParams,
  RemoteDataTable,
  ResponseDataTableModel,
} from '../remote-datatable'

export interface VehicleDataTable extends RemoteDataTable {
  datatable: (params: DataTableParams) => Promise<ResponseDataTableModel>
}
