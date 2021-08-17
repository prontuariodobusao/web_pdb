import {LocalStorageAdapter} from '../../../infra/cache'
export type Account = {
  accessToken: string
  name: string
  role: string
  confirmation?: boolean
}

const localStorage = new LocalStorageAdapter()

export const setCurrentAccountAdapter = (account: Account): void => {
  localStorage.set('@pdb:account', account)
}

export const getCurrentAccountAdapter = (): Account => {
  return localStorage.get('@pdb:account')
}
