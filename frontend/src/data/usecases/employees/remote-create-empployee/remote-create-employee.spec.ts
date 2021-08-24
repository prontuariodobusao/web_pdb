import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockCreateEmployeeParams} from '../../../../domain/test/mock-confirmation'
import {RemoteCreateEmployee} from './remote-create-employee'

type SutTypes = {
  sut: RemoteCreateEmployee
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteCreateEmployee(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteCreateEmployee', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.created,
    }
    const createEmployeeParams = mockCreateEmployeeParams()

    await sut.create(createEmployeeParams)

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('post')
    expect(httpClientSpy.body).toEqual(createEmployeeParams)
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 422', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.unprocessableEntity,
    }

    const promise = sut.create(mockCreateEmployeeParams())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
