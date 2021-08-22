import React from 'react'
import {RemoteEmployeeDatatable} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {DataTable} from '../../presentation/components'

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

export const CreateEmployeeDataTable: React.FC = () => (
  <DataTable
    remoteRequestDatatable={remoteEmployeeDatatable()}
    fields={{
      id: 'id',
      name: 'name',
      identity: 'identity',
      confitmation: 'confitmation',
      occupation: ' occupation: string',
    }}
    idField="id"
  />
)
