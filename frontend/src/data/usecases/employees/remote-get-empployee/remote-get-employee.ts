import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {GetEmployee} from '../../../../domain/usecases/employees/get-employee'
import {EmployeeDataModel} from '../../../../domain/models/employee-models'

export class RemoteGetEmployee implements GetEmployee {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient,
  ) {}

  async get(): Promise<EmployeeDataModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'get',
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as EmployeeDataModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
