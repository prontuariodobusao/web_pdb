import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  UpdateVehicle,
  VehicleParams,
} from '../../../../domain/usecases/vehicles/update-vehicle'
import {VehicleDataModel} from '../../../../domain/models/vehicle-model'

export class RemoteUpateVehicle implements UpdateVehicle {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      VehicleDataModel | ErrorsDetailsModel
    >,
  ) {}

  async update(params: VehicleParams): Promise<VehicleDataModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'put',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as VehicleDataModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
