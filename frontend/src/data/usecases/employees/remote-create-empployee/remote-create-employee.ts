import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  CreateEmployee,
  EmployeeParams,
} from '../../../../domain/usecases/employees/create-employee'
import {EmployeePasswordModel} from '../../../../domain/models/employee-models'

export class RemoteCreateEmployee implements CreateEmployee {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      EmployeePasswordModel | ErrorsDetailsModel
    >,
  ) {}

  async create(params: EmployeeParams): Promise<EmployeePasswordModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.created)
      return httpResponse.body as EmployeePasswordModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
