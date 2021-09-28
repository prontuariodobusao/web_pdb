import {HttpClientSpy, mockErrorsDetails} from '../../../../data/test'
import {DetailError} from '../../../../domain/errors'
import {StatusCode} from '../../../../domain/protocols/http'
import {mockParamsReportMecanicQuery} from '../../../../domain/test/mock-chart-reports'
import faker from 'faker'
import {RemoteChartsReportMecanicByDates} from './remote-charts-report-mecanic-by-dates'

type SutTypes = {
  sut: RemoteChartsReportMecanicByDates
  httpClientSpy: HttpClientSpy
}

const makeSut = (url: string = faker.internet.url()): SutTypes => {
  const httpClientSpy = new HttpClientSpy()
  const sut = new RemoteChartsReportMecanicByDates(url, httpClientSpy)

  return {
    sut,
    httpClientSpy,
  }
}

describe('RemoteChartsReportMecanicByDates', () => {
  it('Should call HttpClient with correct values', async () => {
    const url = faker.internet.url()
    const {sut, httpClientSpy} = makeSut(url)
    httpClientSpy.response = {
      statusCode: StatusCode.ok,
    }
    const paramsQuery = mockParamsReportMecanicQuery()

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

    const promise = sut.post(mockParamsReportMecanicQuery())

    await expect(promise).rejects.toThrow(new DetailError(errorsDetails))
  })
})
