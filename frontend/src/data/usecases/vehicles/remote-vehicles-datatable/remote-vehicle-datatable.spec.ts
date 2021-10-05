import faker from 'faker'
import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockVehicleDataTableParams} from '../../../../domain/test/mock-vehicles'
import {RemoteVehicleDataTable} from './remote-vehicle-datatable'

type SutTypes = {
  sut: RemoteVehicleDataTable
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteVehicleDataTable(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteVehicleDataTable', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }
    const employeeDataTableParams = mockVehicleDataTableParams()

    await sut.datatable(employeeDataTableParams)

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('post')
    expect(httpClientSpy.body).toEqual(employeeDataTableParams)
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 422', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.unprocessableEntity,
    }

    const promise = sut.datatable(mockVehicleDataTableParams())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
