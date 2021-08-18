import React, {ReactNode, useContext} from 'react'
import {Redirect} from 'react-router-dom'
import {AuthContext} from 'presentation/contexts'

type Props = {
  children: ReactNode
}

const AuthGuard: React.FC<Props> = ({children}: Props) => {
  const {getAccount} = useContext(AuthContext)

  if (!getAccount()?.accessToken && !getAccount()?.confirmation) {
    return <Redirect to="/login" />
  }

  return <>{children}</>
}

export default AuthGuard
