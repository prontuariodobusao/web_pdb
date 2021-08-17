import React from 'react'
import {BrowserRouter, Switch, Route} from 'react-router-dom'
import AdminLayout from '../../presentation/layouts/AdminLayout'
import {createSignIn} from '../factories'
import {AuthProvider} from '../../presentation/contexts/auth'

const Routes: React.FC = () => {
  return (
    <AuthProvider>
      <BrowserRouter>
        <Switch>
          <Route path="/dashboard" exact component={AdminLayout} />
          <Route path="/" exact component={createSignIn} />
        </Switch>
      </BrowserRouter>
    </AuthProvider>
  )
}

export default Routes
