import React from 'react'
import {BrowserRouter, Switch, Route} from 'react-router-dom'
import AdminLayout from '../../presentation/layouts/AdminLayout'
import {createSignIn} from '../factories'
import {AuthProvider} from '../../presentation/contexts/auth'
import {ConfirmOrMenu} from '../../presentation/pages'

const Routes: React.FC = () => {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Switch>
          <Route path="/dashboard" exact component={AdminLayout} />
          <Route path="/" exact component={createSignIn} />
          <Route path="/confirmacao" exact component={ConfirmOrMenu} />
        </Switch>
      </BrowserRouter>
    </AuthProvider>
  )
}

export default Routes
