import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {ChartsReport} from '../../../../domain/usecases/charts/charts_report'
import {ReportChartModel} from '../../../../domain/models/charts-model'

export class RemoteChartsReport implements ChartsReport {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      ReportChartModel | ErrorsDetailsModel
    >,
  ) {}

  async get(): Promise<ReportChartModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'get',
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as ReportChartModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
