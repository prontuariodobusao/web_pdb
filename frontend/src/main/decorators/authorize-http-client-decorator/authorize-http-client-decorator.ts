import {GetStorage} from '../../../domain/protocols/cache'
import {
  HttpClient,
  HttpRequest,
  HttpResponse,
} from '../../../domain/protocols/http'

export class AuthorizeHttpClientDecorator implements HttpClient {
  constructor(
    private readonly getStorage: GetStorage,
    private readonly httpClient: HttpClient,
    private readonly contentType: string = 'application/json',
  ) {}

  async request(data: HttpRequest): Promise<HttpResponse> {
    const account = await this.getStorage.get('@pdb:account')
    if (account?.accessToken) {
      Object.assign(data, {
        headers: Object.assign(data.headers || {}, {
          Authorization: account.accessToken,
          'Content-Type': this.contentType,
        }),
      })
    }
    const httpResponse = await this.httpClient.request(data)

    return httpResponse
  }
}
