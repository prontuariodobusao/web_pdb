import React from 'react'
import {RemoteEmployeeDatatable} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {EmployeeDt} from '../../presentation/pages'

const remoteEmployeeDatatable = (): RemoteEmployeeDatatable => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteEmployeeDatatable(
    `${basUrl}/manager/employees/datatable`,
    authHttpClient,
  )
}

export const createEmployeeDataTable: React.FC = () => (
  <EmployeeDt remoteEmployeeDataTable={remoteEmployeeDatatable()} />
)
