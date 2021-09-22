import React from 'react'
import {
  RemoteChartsReportByDates,
  RemoteChartsReportEmployeeProblemsByDates,
  RemoteChartsReportMecanicByDates,
  RemoteListEmployee,
} from '../../data/usecases'
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

const remoteChartsReportEmployeeProblemsByDates =
  (): RemoteChartsReportEmployeeProblemsByDates => {
    const authHttpClient = new AuthorizeHttpClientDecorator(
      new LocalStorageAdapter(),
      new AxiosHttpClient(),
    )

    return new RemoteChartsReportEmployeeProblemsByDates(
      `${basUrl}/manager/charts/report_employee_problems_by_dates`,
      authHttpClient,
    )
  }

const remoteChartsReportMecanicByDates =
  (): RemoteChartsReportMecanicByDates => {
    const authHttpClient = new AuthorizeHttpClientDecorator(
      new LocalStorageAdapter(),
      new AxiosHttpClient(),
    )

    return new RemoteChartsReportMecanicByDates(
      `${basUrl}/manager/charts/report_mecanic_by_dates`,
      authHttpClient,
    )
  }

const remoteListEmployee = (): RemoteListEmployee => {
  const authHttpClient = new AuthorizeHttpClientDecorator(
    new LocalStorageAdapter(),
    new AxiosHttpClient(),
  )

  return new RemoteListEmployee(
    `${basUrl}/manager/employees/list`,
    authHttpClient,
  )
}

export const CreateChartsByDate: React.FC = () => (
  <ChartsByDatePage
    chartsReportByDates={remoteChartsReportByDates()}
    chartsReportEmployeeProblemsByDates={remoteChartsReportEmployeeProblemsByDates()}
    chartsReportMecanicByDates={remoteChartsReportMecanicByDates()}
    listEmployee={remoteListEmployee()}
  />
)
