import {ParamsQuery} from '../usecases/charts/charts-report-mecanic-by-dates'

export const mockParamsReportMecanicQuery = (): ParamsQuery => ({
  data: {
    initial_date: '01/01/2021',
    end_date: '31/08/2021',
  },
})
