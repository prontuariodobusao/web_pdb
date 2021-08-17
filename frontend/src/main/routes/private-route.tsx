import React, {useContext} from 'react'
import {AuthContext} from 'presentation/contexts'
import {RouteProps, Route, Redirect} from 'react-router-dom'

const PrivateRoute: React.FC<RouteProps> = (props: RouteProps) => {
  const {getAccount} = useContext(AuthContext)

  return getAccount()?.accessToken && getAccount()?.confirmation ? (
    <Route {...props} />
  ) : (
    <Route {...props} component={() => <Redirect to="/login" />} />
  )
}

export default PrivateRoute
