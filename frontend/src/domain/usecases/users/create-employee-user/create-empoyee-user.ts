import {UserWithPasswordModel} from '../../../models/user-model'

export interface CreateEmployeeUser {
  create: () => Promise<UserWithPasswordModel>
}
