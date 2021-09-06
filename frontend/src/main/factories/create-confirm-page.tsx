import React from 'react'
import {ConfirmationPage} from '../../presentation/pages'
import {RemoteConfirmation} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'

const remoteConfirmation = (id: string): RemoteConfirmation => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteConfirmation(
    `${basUrl}/users/${id}/confirmation`,
    authHttpClient,
  )
}

type Props = {
  userIdParams: string
}

export const CreateConfirmPage: React.FC<Props> = ({userIdParams}: Props) => (
  <ConfirmationPage confirm={remoteConfirmation(userIdParams)} />
)
