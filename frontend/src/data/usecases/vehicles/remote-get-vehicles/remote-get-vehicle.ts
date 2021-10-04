import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {GetVehicle} from '../../../../domain/usecases/vehicles/get-vehicles'
import {VehicleDataModel} from '../../../../domain/models/vehicle-model'

export class RemoteGetVehicle implements GetVehicle {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      VehicleDataModel | ErrorsDetailsModel
    >,
  ) {}

  async get(): Promise<VehicleDataModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'get',
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as VehicleDataModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
