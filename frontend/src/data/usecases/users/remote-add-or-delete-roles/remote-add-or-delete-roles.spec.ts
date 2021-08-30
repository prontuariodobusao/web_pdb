import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockRoleParams} from '../../../../domain/test/mock-confirmation'
import faker from 'faker'
import {RemoteAddOrRemoveRoles} from './remote-add-or-delete-roles'

type SutTypes = {
  sut: RemoteAddOrRemoveRoles
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteAddOrRemoveRoles(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteAddOrRemoveRoles', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }
    const authenticationParams = mockRoleParams()

    await sut.addOrRemove(authenticationParams)

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('post')
    expect(httpClientSpy.body).toEqual(authenticationParams)
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 422', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.unprocessableEntity,
    }

    const promise = sut.addOrRemove(mockRoleParams())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
