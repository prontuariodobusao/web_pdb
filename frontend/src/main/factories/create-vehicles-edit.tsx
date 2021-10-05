import React from 'react'
import {RemoteUpateVehicle} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {VehiclesEdit} from '../../presentation/pages'
import {remoteGetVehicle} from './create-get-vehicles'

const remoteEditVehicles = (id: string): RemoteUpateVehicle => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteUpateVehicle(
    `${basUrl}/manager/vehicles/${id}`,
    authHttpClient,
  )
}

type Props = {
  idParams: string
}

export const CreateVehiclesEdit: React.FC<Props> = ({idParams}: Props) => (
  <VehiclesEdit
    remoteGetVehicles={remoteGetVehicle(idParams)}
    remoteEditVehicles={remoteEditVehicles(idParams)}
  />
)
