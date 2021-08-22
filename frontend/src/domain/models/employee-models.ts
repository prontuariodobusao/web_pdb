export type EmployeeModel = {
  id: number
  confirmation: boolean
  identity: string
  name: string
  occupation: string
}
export type EmployeeDataTableModel = {
  draw: number
  totalRecords: number
  data: EmployeeModel[]
}
