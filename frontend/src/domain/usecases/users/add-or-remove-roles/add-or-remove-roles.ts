import {UserDataModel} from '../../../models/user-model'

export type RoleParams = {
  data: {
    name: string
  }
}

export interface AddOrRemoveRoles {
  addOrRemove: (params: RoleParams) => Promise<UserDataModel>
}
