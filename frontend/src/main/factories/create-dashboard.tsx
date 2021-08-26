import React from 'react'
import {RemoteChartsReport} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {Dashboard} from '../../presentation/pages'

export const remoteChartsReport = (): RemoteChartsReport => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteChartsReport(
    `${basUrl}/manager/charts/report`,
    authHttpClient,
  )
}

export const CreateDashboard: React.FC = () => (
  <Dashboard chartsReport={remoteChartsReport()} />
)
