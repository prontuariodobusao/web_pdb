import React, {useContext} from 'react'
import {AuthContext} from 'presentation/contexts'
import {RouteProps, Route, Redirect} from 'react-router-dom'

const PrivateRoute: React.FC<RouteProps> = (props: RouteProps) => {
  const {user, token} = useContext(AuthContext)

  return token && user.confirmation ? (
    <Route {...props} />
  ) : (
    <Route {...props} component={() => <Redirect to="/login" />} />
  )
}

export default PrivateRoute
