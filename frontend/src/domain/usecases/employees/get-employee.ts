import {EmployeeDataModel} from '../../models/employee-models'

export interface GetEmployee {
  get: () => Promise<EmployeeDataModel>
}
