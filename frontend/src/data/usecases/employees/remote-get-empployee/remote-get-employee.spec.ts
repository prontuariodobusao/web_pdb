import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockEditEmployeeParams} from '../../../../domain/test/mock-confirmation'
import {RemoteGetEmployee} from './remote-get-employee'

type SutTypes = {
  sut: RemoteGetEmployee
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteGetEmployee(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteGetEmployee', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }

    await sut.get()

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('get')
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 500', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.serverError,
    }

    const promise = sut.get()

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
