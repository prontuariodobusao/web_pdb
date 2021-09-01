import React, {createContext, useState} from 'react'
import jwtDecode from 'jwt-decode'
import {UserModel} from '../../domain/models/user-model'
import {
  setCurrentAccountAdapter,
  getCurrentAccountAdapter,
  Account,
} from '../../main/adapters'
import {remoteCheckTokenValid} from '../../main/factories'

interface AuthContextData {
  token: string
  user: UserModel
  saveAccount: (accesaToken: string) => Promise<void>
  getAccount: () => Promise<void>
  getCurrentAccount: () => Account
  signOut: () => Promise<void>
  updateStateAccount: (user: UserModel) => void
  checkTokenValid: () => Promise<void>
}

type TokenData = {
  user_id: string
  name: string
  confirmation: boolean
  occupation: string
}

type StateData = {
  accessToken: string
  user: UserModel
}

const AuthContext = createContext<AuthContextData>({} as AuthContextData)

export const AuthProvider: React.FC = ({children}: any) => {
  const [data, setData] = useState<StateData>({} as StateData)

  const saveAccount = async (accessToken: any): Promise<void> => {
    try {
      // eslint-disable-next-line @typescript-eslint/naming-convention
      const {user_id, name, confirmation, occupation} =
        jwtDecode<TokenData>(accessToken)

      setCurrentAccountAdapter({
        id: user_id,
        accessToken,
        name,
        role: occupation,
        confirmation,
      })

      setData({
        ...data,
        accessToken,
        user: {
          id: user_id,
          employee_name: name,
          confirmation,
          occupation,
        },
      })
    } catch (error) {
      console.log(error)
    }
  }

  const checkTokenValid = async (): Promise<void> => {
    try {
      await remoteCheckTokenValid().check()
      const account = await getCurrentAccountAdapter()

      const {id, accessToken, name, confirmation, role} = account
      setData({
        ...data,
        accessToken,
        user: {
          id,
          employee_name: name,
          confirmation,
          occupation: role,
        },
      })
    } catch (error) {
      await localStorage.removeItem('@pdb:account')
      setData({} as StateData)
    }
  }

  const getAccount = async (): Promise<void> => {
    const account = await getCurrentAccountAdapter()
    if (account) {
      const {id, accessToken, name, confirmation, role} = account
      setData({
        ...data,
        accessToken,
        user: {
          id,
          employee_name: name,
          confirmation,
          occupation: role,
        },
      })
    }
  }

  const getCurrentAccount = (): Account => getCurrentAccountAdapter()

  const updateStateAccount = async (user: UserModel): Promise<void> => {
    // eslint-disable-next-line @typescript-eslint/naming-convention
    const {id, employee_name, confirmation, occupation} = user
    setCurrentAccountAdapter({
      id,
      accessToken: data.accessToken,
      name: employee_name,
      role: occupation,
      confirmation,
    })
    setData({
      ...data,
      user: {
        id,
        employee_name,
        confirmation,
        occupation,
      },
    })
  }

  const signOut = async (): Promise<void> => {
    localStorage.removeItem('@pdb:account')
    setData({} as StateData)
  }

  return (
    <AuthContext.Provider
      value={{
        token: data.accessToken,
        saveAccount,
        getAccount,
        signOut,
        updateStateAccount,
        checkTokenValid,
        getCurrentAccount,
        user: data.user,
      }}>
      {children}
    </AuthContext.Provider>
  )
}

export default AuthContext
