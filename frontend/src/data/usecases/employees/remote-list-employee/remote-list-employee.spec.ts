import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {RemoteListEmployee} from './remote-list-employee'

type SutTypes = {
  sut: RemoteListEmployee
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteListEmployee(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteListEmployee', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }

    await sut.list()

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('get')
  })

  it('Should call HttpClient with correct url and parameter driver', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }

    await sut.list('driver')

    expect(httpClientSpy.url).toEqual(`${url}?type_occupation=driver`)
    expect(httpClientSpy.method).toBe('get')
  })

  it('Should call HttpClient with correct url and parameter mecanic', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }

    await sut.list('mecanic')

    expect(httpClientSpy.url).toEqual(`${url}?type_occupation=mecanic`)
    expect(httpClientSpy.method).toBe('get')
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 500', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.serverError,
    }

    const promise = sut.list()

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
