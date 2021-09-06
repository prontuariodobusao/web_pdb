import React from 'react'
import {RemoteAddOrRemoveRoles} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {AddOrRemoveRolesPage} from '../../presentation/pages'
import {UserModel} from '../../domain/models/user-model'

export const remoteAddOrRemoveRoles = (id: string): RemoteAddOrRemoveRoles => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteAddOrRemoveRoles(
    `${basUrl}/manager/users/${id}/add_or_remove_role`,
    authHttpClient,
  )
}

type Props = {
  user: UserModel
}

export const CreateAddOrRemoveRolesPage: React.FC<Props> = ({user}: Props) => (
  <AddOrRemoveRolesPage
    addOrRemoveRoles={remoteAddOrRemoveRoles(String(user.id))}
    user={user}
  />
)
