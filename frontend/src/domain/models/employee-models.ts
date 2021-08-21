export type EmployeeModel = {
  id: number
  confitmation: boolean
  identity: string
  name: string
  occupation: string
}
export type EmployeeDataTableModel = {
  draw: number
  totalRecords: number
  data: EmployeeModel[]
}
