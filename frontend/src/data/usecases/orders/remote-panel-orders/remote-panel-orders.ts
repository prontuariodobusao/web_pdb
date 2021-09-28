import {ErrorsDetailsModel} from '../../../models'
import {DetailError} from '../../../../domain/errors'
import {HttpClient, StatusCode} from '../../../../domain/protocols/http'
import {PanelOrders} from '../../../../domain/usecases/orders/panel-orders'
import {OrderPanelModel} from '../../../../domain/models/order-model'

export class RemotePanelOrders implements PanelOrders {
  constructor(
    private readonly url: string,
    private readonly httpClient: HttpClient<
      OrderPanelModel | ErrorsDetailsModel
    >,
  ) {}

  async get(): Promise<OrderPanelModel> {
    const httpResponse = await this.httpClient.request({
      url: this.url,
      method: 'get',
    })

    if (httpResponse.statusCode === StatusCode.ok)
      return httpResponse.body as OrderPanelModel

    throw new DetailError(httpResponse.body as ErrorsDetailsModel)
  }
}
