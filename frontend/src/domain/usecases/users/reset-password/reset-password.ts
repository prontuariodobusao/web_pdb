import {UserWithPasswordModel} from '../../../models/user-model'

export interface ResetPassword {
  resetPassword: () => Promise<UserWithPasswordModel>
}
