import React from 'react'
import {RemoteUserResetPassword} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {UserResetPasswordPage} from '../../presentation/pages'

export const remoteUserResetPassword = (
  id: string,
): RemoteUserResetPassword => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteUserResetPassword(
    `${basUrl}/manager/users/${id}/reset_password`,
    authHttpClient,
  )
}

type Props = {
  userIdParams: string
}

export const CreateUserResetPassword: React.FC<Props> = ({
  userIdParams,
}: Props) => (
  <UserResetPasswordPage
    resetPassword={remoteUserResetPassword(userIdParams)}
  />
)
