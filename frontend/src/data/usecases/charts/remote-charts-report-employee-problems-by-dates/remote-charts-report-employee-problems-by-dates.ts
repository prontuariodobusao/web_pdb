import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  ChartsReportEmployeeProblemsByDates,
  ParamsReportQuery,
} from '../../../../domain/usecases/charts/charts-report_employee_problems_by_dates'
import {ReportModel} from '../../../../domain/models/charts-model'

export class RemoteChartsReportEmployeeProblemsByDates
  implements ChartsReportEmployeeProblemsByDates
{
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<ReportModel | ErrorsDetailsModel>,
  ) {}

  async post(params: ParamsReportQuery): Promise<ReportModel> {
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
