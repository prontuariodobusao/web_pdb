import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  CreateVehicle,
  VehicleParams,
} from '../../../../domain/usecases/vehicles/create-vehicle'
import {VehicleDataModel} from '../../../../domain/models/vehicle-model'

export class RemoteCreateVehicle implements CreateVehicle {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      VehicleDataModel | ErrorsDetailsModel
    >,
  ) {}

  async create(params: VehicleParams): Promise<VehicleDataModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.created)
      return httpResponse.body as VehicleDataModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
