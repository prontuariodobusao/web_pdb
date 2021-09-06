import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  EditEmployee,
  EmployeeEditParams,
} from '../../../../domain/usecases/employees/edit-employee'
import {EmployeeDataModel} from '../../../../domain/models/employee-models'

export class RemoteEditEmployee implements EditEmployee {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      EmployeeDataModel | ErrorsDetailsModel
    >,
  ) {}

  async edit(params: EmployeeEditParams): Promise<EmployeeDataModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'put',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as EmployeeDataModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
