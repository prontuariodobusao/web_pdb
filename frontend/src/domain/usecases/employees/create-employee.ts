import {EmployeePasswordModel} from '../../models/employee-models'

export type EmployeeParams = {
  data: {
    name: string
    identity: string
    occupation_id: number
    is_user: boolean
  }
}

export interface CreateEmployee {
  create: (params: EmployeeParams) => Promise<EmployeePasswordModel>
}
