import {UserDataModel} from '../../models/user-model'

export type ConfirmParams = {
  password: string
  password_confirmation: string
}

export type ConfirmDataParams = {
  data: ConfirmParams
}

export interface Confirmation {
  confirm: (params: ConfirmDataParams) => Promise<UserDataModel>
}
