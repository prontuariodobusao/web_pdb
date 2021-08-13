import {ErrorsDetailsModel, ErrorsModel} from '../../data/models'

export interface HandleErrors {
  handleErrors: (error: ErrorsDetailsModel) => ErrorsModel[]
}

export interface GetMessageError {
  name: string
  message: string
  getErrors: () => ErrorsModel[] | string
}
