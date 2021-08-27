import {ParamsQuery} from '../usecases/charts/charts-report-by-dates'

export const mockParamsQuery = (): ParamsQuery => ({
  data: {
    type_report: 3,
    initial_date: '01/01/2021',
    end_date: '31/08/2021',
  },
})
