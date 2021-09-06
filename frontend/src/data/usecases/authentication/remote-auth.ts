import {InvalidCredentialsError, UnexpectedError} from '../../../domain/errors'
import {AccountModel} from '../../../domain/models/account-model'
import {HttpClient, StatusCode} from '../../../domain/protocols/http'
import {
  Authentication,
  AuthParams,
} from '../../../domain/usecases/auth/authentication'

export class RemoteAuth implements Authentication {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<AccountModel>,
  ) {}

  async auth(params: AuthParams): Promise<AccountModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
      body: params,
    })

    switch (httpResponse.statusCode) {
      case StatusCode.ok:
        return httpResponse.body as AccountModel
      case StatusCode.unauthorized:
        throw new InvalidCredentialsError()
      default:
        throw new UnexpectedError()
    }
  }
}
