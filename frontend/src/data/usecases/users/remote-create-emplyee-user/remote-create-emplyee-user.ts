import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {CreateEmployeeUser} from '../../../../domain/usecases/users/create-employee-user/create-empoyee-user'
import {UserWithPasswordModel} from '../../../../domain/models/user-model'

export class RemoteUserCreateEmployeeUser implements CreateEmployeeUser {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      UserWithPasswordModel | ErrorsDetailsModel
    >,
  ) {}

  async create(): Promise<UserWithPasswordModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'post',
    })

    if (httpResponse.statusCode === StatusCode.created)
      return httpResponse.body as UserWithPasswordModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
