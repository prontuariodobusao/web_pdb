import React, {ReactNode, useContext, useEffect, useState} from 'react'
import {Redirect} from 'react-router-dom'
import {AuthContext} from 'presentation/contexts'

type Props = {
  children: ReactNode
}

const AuthGuard: React.FC<Props> = ({children}: Props) => {
  const {user, token, checkTokenValid, getCurrentAccount} =
    useContext(AuthContext)
  const [loading, setLoading] = useState(true)
  const [access, setAccess] = useState(true)

  useEffect(() => {
    checkTokenValid()
  }, [])

  return getCurrentAccount()?.accessToken &&
    getCurrentAccount()?.confirmation ? (
    <>{children}</>
  ) : (
    <Redirect to="/login" />
  )
}

export default AuthGuard
