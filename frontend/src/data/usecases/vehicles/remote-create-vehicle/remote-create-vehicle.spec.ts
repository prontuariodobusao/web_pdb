import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockVehicleDataModel} from '../../../../domain/test/mock-vehicles'
import {RemoteCreateVehicle} from './remote-create-vehicle'

type SutTypes = {
  sut: RemoteCreateVehicle
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteCreateVehicle(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteCreateVehicle', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.created,
    }
    const createVehicleParams = mockVehicleDataModel()

    await sut.create(createVehicleParams)

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('post')
    expect(httpClientSpy.body).toEqual(createVehicleParams)
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 422', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.unprocessableEntity,
    }

    const promise = sut.create(mockVehicleDataModel())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
