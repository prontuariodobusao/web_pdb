import {RemoteCheckTokenValid} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'

export const remoteCheckTokenValid = (): RemoteCheckTokenValid => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteCheckTokenValid(`${basUrl}/`, authHttpClient)
}
