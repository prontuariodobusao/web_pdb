import {ErrorsDetailsModel} from '../../models'
import {DetailError} from '../../../domain/errors'
import {UserDataModel} from '../../../domain/models/user-model'
import {HttpClient, StatusCode} from '../../../domain/protocols/http'
import {
  Confirmation,
  ConfirmDataParams,
} from '../../../domain/usecases/confirm/confirmation'

export class RemoteConfirmation implements Confirmation {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<UserDataModel | ErrorsDetailsModel>,
  ) {}

  async confirm(params: ConfirmDataParams): Promise<UserDataModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.created)
      return httpResponse.body as UserDataModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
