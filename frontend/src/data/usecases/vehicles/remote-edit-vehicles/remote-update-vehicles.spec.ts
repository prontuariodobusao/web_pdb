import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockVehicleDataModel} from '../../../../domain/test/mock-vehicles'
import {RemoteUpateVehicle} from './remote-update-vehicles'

type SutTypes = {
  sut: RemoteUpateVehicle
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteUpateVehicle(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteUpateVehicle', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }
    const createEmployeeParams = mockVehicleDataModel()

    await sut.update(createEmployeeParams)

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('put')
    expect(httpClientSpy.body).toEqual(createEmployeeParams)
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 422', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.unprocessableEntity,
    }

    const promise = sut.update(mockVehicleDataModel())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
