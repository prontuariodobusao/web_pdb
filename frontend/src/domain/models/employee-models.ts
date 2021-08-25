export type EmployeeModel = {
  id: number
  confirmation?: boolean
  identity: string
  name: string
  occupation: string
}
export type EmployeeDataTableModel = {
  draw: number
  totalRecords: number
  data: EmployeeModel[]
}

export type EmployeePasswordModel = {
  employee: {
    data: {
      id: number
      name: string
      identity: string
      occupation: string
    }
    meta: {
      links: {
        self: string
      }
    }
  }
  password: string
}

export type EmployeeDataModel = {
  employee: {
    data: {
      id: number
      name: string
      identity: string
      occupation: string
    }
    meta: {
      links: {
        self: string
      }
    }
  }
}
