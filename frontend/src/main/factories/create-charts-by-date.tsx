import React from 'react'
import {RemoteChartsReportByDates} from '../../data/usecases'
import {basUrl} from '../../services'
import {AuthorizeHttpClientDecorator} from '../decorators'
import {AxiosHttpClient} from '../../infra/http'
import {LocalStorageAdapter} from '../../infra/cache'
import {ChartsByDatePage} from '../../presentation/pages'

const remoteChartsReportByDates = (): RemoteChartsReportByDates => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteChartsReportByDates(
    `${basUrl}/manager/charts/report_by_dates`,
    authHttpClient,
  )
}

export const CreateChartsByDate: React.FC = () => (
  <ChartsByDatePage chartsReportByDates={remoteChartsReportByDates()} />
)
