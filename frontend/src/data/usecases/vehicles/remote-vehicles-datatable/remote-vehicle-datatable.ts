import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {VehicleDataTable} from '../../../../domain/usecases/vehicles/vehicle-datatable'
import {
  DataTableParams,
  ResponseDataTableModel,
} from '../../../../domain/usecases/remote-datatable'

export class RemoteVehicleDataTable implements VehicleDataTable {
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
