import React from 'react'
import {PanelMecanicOrders} from '../../presentation/pages'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {RemotePanelOrders} from '../../data/usecases'

const remotePanelOrders = (): RemotePanelOrders => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemotePanelOrders(`${basUrl}/manager/orders/panel`, authHttpClient)
}

export const CreatePanelMecanicOrdersPage: React.FC = () => (
  <PanelMecanicOrders panelOrders={remotePanelOrders()} />
)
