import {InvalidCredentialsError} from '../../../domain/errors'
import {HttpClient, StatusCode} from '../../../domain/protocols/http'
import {CheckTokenValid} from '../../../domain/usecases/check-token-valid'

export class RemoteCheckTokenValid implements CheckTokenValid {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient,
  ) {}

  async check(): Promise<void> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'get',
    })

    if (httpResponse.statusCode !== StatusCode.ok)
      throw new InvalidCredentialsError()
  }
}
