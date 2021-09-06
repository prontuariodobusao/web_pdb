import {
  DataTableParams,
  RemoteDataTable,
  ResponseDataTableModel,
} from '../remote-datatable'

export interface EmployeeDataTable extends RemoteDataTable {
  datatable: (params: DataTableParams) => Promise<ResponseDataTableModel>
}
