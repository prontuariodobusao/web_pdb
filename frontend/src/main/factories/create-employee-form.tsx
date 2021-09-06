import React from 'react'
import {RemoteCreateEmployee} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {EmployeeForm} from '../../presentation/pages'

const remoteCreateEmployee = (): RemoteCreateEmployee => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteCreateEmployee(`${basUrl}/manager/employees`, authHttpClient)
}

export const CreateEmployeeForm: React.FC = () => (
  <EmployeeForm remoteCreateEmployee={remoteCreateEmployee()} />
)
