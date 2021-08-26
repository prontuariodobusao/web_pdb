import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {ResetPassword} from '../../../../domain/usecases/users/reset-password/reset-password'
import {UserWithPasswordModel} from '../../../../domain/models/user-model'

export class RemoteUserResetPassword implements ResetPassword {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      UserWithPasswordModel | ErrorsDetailsModel
    >,
  ) {}

  async resetPassword(): Promise<UserWithPasswordModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'get',
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as UserWithPasswordModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
