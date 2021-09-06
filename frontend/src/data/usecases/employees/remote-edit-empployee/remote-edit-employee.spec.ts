import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockEditEmployeeParams} from '../../../../domain/test/mock-confirmation'
import {RemoteEditEmployee} from './remote-edit-employee'

type SutTypes = {
  sut: RemoteEditEmployee
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteEditEmployee(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteEditEmployee', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }
    const createEmployeeParams = mockEditEmployeeParams()

    await sut.edit(createEmployeeParams)

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

    const promise = sut.edit(mockEditEmployeeParams())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
