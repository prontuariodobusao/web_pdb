import React from 'react'
import {RemoteVehicleDataTable} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {VehiclesDt} from '../../presentation/pages'
import {DataTableContextProvider} from '../../presentation/contexts/datatable-context'

const remoteVehiclesDatatable = (): RemoteVehicleDataTable => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteVehicleDataTable(
    `${basUrl}/manager/vehicles/datatable`,
    authHttpClient,
  )
}

export const CreatevehiclesDataTable: React.FC = () => (
  <DataTableContextProvider>
    <VehiclesDt remoteVehiclesDataTable={remoteVehiclesDatatable()} />
  </DataTableContextProvider>
)
