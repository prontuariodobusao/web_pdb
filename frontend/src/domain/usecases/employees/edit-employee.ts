import {EmployeeDataModel} from '../../models/employee-models'

export type EmployeeEditParams = {
  data: {
    name: string
    identity: string
    occupation_id: number
  }
}

export interface EditEmployee {
  edit: (params: EmployeeEditParams) => Promise<EmployeeDataModel>
}
