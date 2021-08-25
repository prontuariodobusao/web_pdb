import React from 'react'
import {RemoteEditEmployee} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {EmployeeEdit} from '../../presentation/pages'
import {remoteGetEmployee} from './create-get-employee'

const remoteEditEmployee = (id: string): RemoteEditEmployee => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteEditEmployee(
    `${basUrl}/manager/employees/${id}`,
    authHttpClient,
  )
}

type Props = {
  idParams: string
}

export const CreateEmployeeEdit: React.FC<Props> = ({idParams}: Props) => (
  <EmployeeEdit
    remoteGetEmployee={remoteGetEmployee(idParams)}
    remoteEditEmployee={remoteEditEmployee(idParams)}
  />
)
