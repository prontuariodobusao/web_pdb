import React from 'react'
import {BrowserRouter, Switch, Route} from 'react-router-dom'
import AdminLayout from '../../presentation/layouts/AdminLayout'
import {SignIn} from '../../presentation/pages'

const Routes: React.FC = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/dashboard" exact component={AdminLayout} />
        <Route path="/" exact component={SignIn} />
      </Switch>
    </BrowserRouter>
  )
}

export default Routes
