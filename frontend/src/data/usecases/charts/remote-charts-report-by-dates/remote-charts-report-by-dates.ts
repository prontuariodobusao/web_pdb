import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  ChartsReportByDates,
  ParamsQuery,
} from '../../../../domain/usecases/charts/charts-report-by-dates'
import {ReportModel} from '../../../../domain/models/charts-model'

export class RemoteChartsReportByDates implements ChartsReportByDates {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<ReportModel | ErrorsDetailsModel>,
  ) {}

  async post(params: ParamsQuery): Promise<ReportModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as ReportModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
