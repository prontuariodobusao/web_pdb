import React, {ReactNode, useContext, useEffect} from 'react'
import {Redirect} from 'react-router-dom'
import {AuthContext} from 'presentation/contexts'
import {BASE_URL} from '../../config/constant'

type Props = {
  children: ReactNode
}

const GuestGuard: React.FC<Props> = ({children}: Props) => {
  const {user, token, getAccount} = useContext(AuthContext)

  getAccount()

  if (!!token && user.confirmation) {
    return <Redirect to={BASE_URL} />
  }

  return <>{children}</>
}

export default GuestGuard
