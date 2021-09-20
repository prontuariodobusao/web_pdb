import {OrderPanelModel} from '../../models/order-model'

export interface PanelOrders {
  get: () => Promise<OrderPanelModel>
}
