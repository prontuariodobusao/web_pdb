import {ErrorsDetailsModel, ErrorsModel} from '../../data/models'
import {GetMessageError} from '../../domain/errors'

export class DetailError extends Error implements GetMessageError {
  constructor(private readonly errorObject: ErrorsDetailsModel) {
    super('Não foi possível realizar a ação!')
    this.name = 'DetailError'
  }

  getErrors(): ErrorsModel[] {
    return this.errorObject.errors
  }
}
