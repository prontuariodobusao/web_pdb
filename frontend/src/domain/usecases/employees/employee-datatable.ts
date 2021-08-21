import {EmployeeDataTableModel} from '../../models/employee-models'

export type EmployeeDataTableParams = {
  draw: number
  page: number
  per_page: number
  sort_field?: any
  sort_direction: string
  search_value?: string
}

export interface EmployeeDataTable {
  datatable: (
    params: EmployeeDataTableParams,
  ) => Promise<EmployeeDataTableModel>
}
