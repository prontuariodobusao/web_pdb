import {EmployeeDataTableModel} from '../../models/employee-models'
import {DataTableParams, RemoteDataTable} from '../remote-datatable'

export interface EmployeeDataTable
  extends RemoteDataTable<EmployeeDataTableModel> {
  datatable: (params: DataTableParams) => Promise<EmployeeDataTableModel>
}
