import {ErrorsDetailsModel} from '../../models'
import {DetailError} from '../../../domain/errors'
import {HttpClient, StatusCode} from '../../../domain/protocols/http'
import {
  EmployeeDataTable,
  EmployeeDataTableParams,
} from 'domain/usecases/employees/employee-datatable'
import {EmployeeDataTableModel} from 'domain/models/employee-models'

export class RemoteEmployeeDatatable implements EmployeeDataTable {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      EmployeeDataTableModel | ErrorsDetailsModel
    >,
  ) {}

  async datatable(
    params: EmployeeDataTableParams,
  ): Promise<EmployeeDataTableModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as EmployeeDataTableModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
