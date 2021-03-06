import {UserModel} from './user-model'

export type EmployeeModel = {
  id: number
  confirmation?: boolean
  identity: string
  name: string
  occupation_id?: number
  occupation: string
  user?: UserModel
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
  data: {
    id: number
    name: string
    identity: string
    occupation: string
    occupation_id: number
  }
  meta: {
    links: {
      self: string
    }
  }
}

type List = {
  id: number
  name: string
}

export type ListEmployeeData = List[]
