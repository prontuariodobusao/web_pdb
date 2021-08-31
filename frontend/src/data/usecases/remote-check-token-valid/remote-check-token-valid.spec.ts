import {InvalidCredentialsError} from '../../../domain/errors'
import {StatusCode} from '../../../domain/protocols/http'

import faker from 'faker'
import {RemoteCheckTokenValid} from './remote-check-token-valid'
import {HttpClientSpy} from '../../../data/test'

type SutTypes = {
  sut: RemoteCheckTokenValid
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteCheckTokenValid(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteCheckTokenValid', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)

    await sut.check()

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('get')
  })

  it('Should throw InvalidCredentialsError if HttpClient returns 401', async () => {
    const {sut, httpClientSpy} = makeSut()
    httpClientSpy.response = {
      statusCode: StatusCode.unauthorized,
    }

    const promise = sut.check()

    await expect(promise).rejects.toThrow(new InvalidCredentialsError())
  })
})
