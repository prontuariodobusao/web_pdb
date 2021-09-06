import {ErrorsDetailsModel} from '../../models'
import {DetailError} from '../../../domain/errors'
import {HttpClient, StatusCode} from '../../../domain/protocols/http'
import {EmployeeDataTable} from '../../../domain/usecases/employees/employee-datatable'
import {
  DataTableParams,
  ResponseDataTableModel,
} from '../../../domain/usecases/remote-datatable'

export class RemoteEmployeeDatatable implements EmployeeDataTable {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      ResponseDataTableModel | ErrorsDetailsModel
    >,
  ) {}

  async datatable(params: DataTableParams): Promise<ResponseDataTableModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as ResponseDataTableModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
