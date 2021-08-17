import React, {createContext, useState} from 'react'
import jwtDecode from 'jwt-decode'
import {UserModel} from '../../domain/models/user-model'

interface AuthContextData {
  token: string
  user: UserModel
  saveAccount: (accesaToken: string) => Promise<void>
  signOut: () => Promise<void>
  updateStateAccount: (user: UserModel) => void
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

      await localStorage.setItem('@pdb:access_token', accessToken)

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

  const updateStateAccount = async (user: UserModel): Promise<void> => {
    // eslint-disable-next-line @typescript-eslint/naming-convention
    const {id, employee_name, confirmation, occupation} = user

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
    await localStorage.removeItem('@pdb:access_token')

    setData({} as StateData)
  }

  return (
    <AuthContext.Provider
      value={{
        token: data.accessToken,
        saveAccount,
        signOut,
        updateStateAccount,
        user: data.user,
      }}>
      {children}
    </AuthContext.Provider>
  )
}

export default AuthContext
