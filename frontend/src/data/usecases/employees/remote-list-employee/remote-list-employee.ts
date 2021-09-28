import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {ListEmployee} from '../../../../domain/usecases/employees/list-employee'
import {ListEmployeeData} from '../../../../domain/models/employee-models'

export class RemoteListEmployee implements ListEmployee {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      ListEmployeeData | ErrorsDetailsModel
    >,
  ) {}

  async list(typeOccupation?: string): Promise<ListEmployeeData> {
    const url = typeOccupation
      ? `${this.url}?type_occupation=${typeOccupation}`
      : this.url

    const httpResponse = await this.httpClient.request({
      url,
      method: 'get',
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as ListEmployeeData

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
