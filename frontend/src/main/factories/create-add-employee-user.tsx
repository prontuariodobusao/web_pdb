import React from 'react'
import {RemoteUserCreateEmployeeUser} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {CreateEmployeeUserPage} from '../../presentation/pages'

export const remoteUserCreateEmployeeUser = (
  employee_id: string,
): RemoteUserCreateEmployeeUser => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteUserCreateEmployeeUser(
    `${basUrl}/manager/employees/${employee_id}/users`,
    authHttpClient,
  )
}

type Props = {
  employeeId: string
}

export const CreateAddEmployeeUser: React.FC<Props> = ({employeeId}: Props) => (
  <CreateEmployeeUserPage
    createEmployeeUser={remoteUserCreateEmployeeUser(employeeId)}
  />
)
