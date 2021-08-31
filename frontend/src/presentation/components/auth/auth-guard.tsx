import React, {ReactNode, useContext} from 'react'
import {Redirect} from 'react-router-dom'
import {AuthContext} from 'presentation/contexts'

type Props = {
  children: ReactNode
}

const AuthGuard: React.FC<Props> = ({children}: Props) => {
  const {user, token} = useContext(AuthContext)

  if (!!token && user.confirmation) {
    return <>{children}</>
  }

  return <Redirect to="/login" />
}

export default AuthGuard
