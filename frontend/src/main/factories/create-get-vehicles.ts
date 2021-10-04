import {RemoteGetVehicle} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'

export const remoteGetVehicle = (id: string): RemoteGetVehicle => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteGetVehicle(
    `${basUrl}/manager/vehicles/${id}`,
    authHttpClient,
  )
}
