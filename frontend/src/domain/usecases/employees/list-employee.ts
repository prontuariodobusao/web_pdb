import {ListEmployeeData} from '../../models/employee-models'

export interface ListEmployee {
  list: (typeOccupation?: string) => Promise<ListEmployeeData>
}
