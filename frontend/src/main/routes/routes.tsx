import React from 'react'
import {BrowserRouter, Switch, Route} from 'react-router-dom'
import AdminLayout from '../../presentation/layouts/AdminLayout'

const Routes: React.FC = () => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path="/" exact component={AdminLayout} />
      </Switch>
    </BrowserRouter>
  )
}

export default Routes
