import {EmployeeDataTableModel} from '../../models/employee-models'
import {DataTableParams, DataTable} from '../datatable'

export interface EmployeeDataTable extends DataTable<EmployeeDataTableModel> {
  datatable: (params: DataTableParams) => Promise<EmployeeDataTableModel>
}
