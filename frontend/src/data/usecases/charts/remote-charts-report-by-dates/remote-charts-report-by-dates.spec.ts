import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockParamsQuery} from '../../../../domain/test/mock-params-query'
import faker from 'faker'
import {RemoteChartsReportByDates} from './remote-charts-report-by-dates'

type SutTypes = {
  sut: RemoteChartsReportByDates
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteChartsReportByDates(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteChartsReportByDates', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }
    const paramsQuery = mockParamsQuery()

    await sut.post(paramsQuery)

    expect(httpClientSpy.url).toEqual(url)
    expect(httpClientSpy.method).toBe('post')
    expect(httpClientSpy.body).toEqual(paramsQuery)
  })

  it('Should throw UnprocessableEntityError if HttpClient returns 422', async () => {
    const {sut, httpClientSpy} = makeSut()
    const errorsDetails = mockErrorsDetails()
    httpClientSpy.response = {
      statusCode: StatusCode.unprocessableEntity,
    }

    const promise = sut.post(mockParamsQuery())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
