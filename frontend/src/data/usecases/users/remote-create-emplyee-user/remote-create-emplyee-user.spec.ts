import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {RemoteUserCreateEmployeeUser} from './remote-create-emplyee-user'

type SutTypes = {
  sut: RemoteUserCreateEmployeeUser
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteUserCreateEmployeeUser(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteUserCreateEmployeeUser', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.created,
    }

    await sut.create()

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('post')
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 500', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.serverError,
    }

    const promise = sut.create()

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
