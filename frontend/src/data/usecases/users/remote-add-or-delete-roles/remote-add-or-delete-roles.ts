import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {UserDataModel} from '../../../../domain/models/user-model'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {
  AddOrRemoveRoles,
  RoleParams,
} from '../../../../domain/usecases/users/add-or-remove-roles/add-or-remove-roles'

export class RemoteAddOrRemoveRoles implements AddOrRemoveRoles {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<UserDataModel | ErrorsDetailsModel>,
  ) {}

  async addOrRemove(params: RoleParams): Promise<UserDataModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as UserDataModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
