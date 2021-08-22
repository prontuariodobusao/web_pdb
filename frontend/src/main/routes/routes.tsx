import React, {Fragment, ReactNode, Suspense} from 'react'
import {Switch, Route} from 'react-router-dom'
import AdminLayout from '../../presentation/layouts/AdminLayout'
import {createSignIn, createEmployeeDataTable} from '../factories'
import {ConfirmOrMenu, Dashboard, Workers} from '../../presentation/pages'
import {AuthGuard, GuestGuard, Loader} from '../../presentation/components'

export type RoutesProps = {
  exact: boolean
  path: string
  component: ReactNode
}

export type RouterProps = {
  exact?: boolean
  guard: ReactNode
  path: string
  component?: ReactNode
  layout?: any
  routes?: RoutesProps[]
}

export const renderRoutes = (routes: RouterProps[] = []): any => {
  return (
    <Suspense fallback={<Loader />}>
      <Switch>
        {routes.map((route: any, i: any) => {
          const Guard = route.guard || Fragment
          const Layout = route.layout || Fragment
          const Component = route.component

          return (
            <Route
              key={i}
              path={route.path}
              exact={route.exact}
              render={props => (
                <Guard>
                  <Layout>
                    {route.routes ? (
                      renderRoutes(route.routes)
                    ) : (
                      <Component {...props} />
                    )}
                  </Layout>
                </Guard>
              )}
            />
          )
        })}
      </Switch>
    </Suspense>
  )
}

const routes: RouterProps[] = [
  {
    exact: true,
    guard: GuestGuard,
    path: '/login',
    component: createSignIn,
  },
  {
    exact: true,
    guard: GuestGuard,
    path: '/confirmacao',
    component: ConfirmOrMenu,
  },
  {
    guard: AuthGuard,
    path: '*',
    layout: AdminLayout,
    routes: [
      {
        exact: true,
        path: '/dashboard',
        component: Dashboard,
      },
      {
        exact: true,
        path: '/funcionarios',
        component: createEmployeeDataTable,
      },
    ],
  },
]

export default routes
