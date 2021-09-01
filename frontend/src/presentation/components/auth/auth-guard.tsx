import React, {ReactNode, useContext, useEffect} from 'react'
import {Redirect} from 'react-router-dom'
import {AuthContext} from 'presentation/contexts'

type Props = {
  children: ReactNode
}

const AuthGuard: React.FC<Props> = ({children}: Props) => {
  const {checkTokenValid, getCurrentAccount} = useContext(AuthContext)
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
