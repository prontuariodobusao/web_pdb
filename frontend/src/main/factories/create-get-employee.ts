import {RemoteGetEmployee} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'

export const remoteGetEmployee = (id: string): RemoteGetEmployee => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteGetEmployee(
    `${basUrl}/manager/employees/${id}`,
    authHttpClient,
  )
}
