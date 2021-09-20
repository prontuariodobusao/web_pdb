import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  ChartsReportMecanicByDates,
  ParamsQuery,
} from '../../../../domain/usecases/charts/charts-report-mecanic-by-dates'
import {ReportOrderByMecanic} from '../../../../domain/models/charts-model'

export class RemoteChartsReportMecanicByDates
  implements ChartsReportMecanicByDates
{
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      ReportOrderByMecanic | ErrorsDetailsModel
    >,
  ) {}

  async post(params: ParamsQuery): Promise<ReportOrderByMecanic> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as ReportOrderByMecanic

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
