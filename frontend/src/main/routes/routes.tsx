import React from 'react'
import {BrowserRouter, Switch, Route} from 'react-router-dom'
import AdminLayout from '../../presentation/layouts/AdminLayout'
import {createSignIn} from '../factories'
import {AuthProvider} from '../../presentation/contexts/auth'
import {ConfirmOrMenu} from '../../presentation/pages'
import PrivateRoute from './private-route'

const Routes: React.FC = () => {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Switch>
          <Route path="/login" exact component={createSignIn} />
          <Route path="/confirmacao" exact component={ConfirmOrMenu} />
          <PrivateRoute path="/dashboard" exact component={AdminLayout} />
        </Switch>
      </BrowserRouter>
    </AuthProvider>
  )
}

export default Routes
