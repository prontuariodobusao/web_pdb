import React from 'react'
import {RemoteCreateVehicle} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {VehiclesForm} from '../../presentation/pages'

const remoteCreateVehicle = (): RemoteCreateVehicle => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteCreateVehicle(`${basUrl}/manager/vehicles`, authHttpClient)
}

export const CreateVehiclesForm: React.FC = () => (
  <VehiclesForm remoteCreateVehicles={remoteCreateVehicle()} />
)
