import {ParamsQuery} from '../usecases/charts/charts-report-mecanic-by-dates'
import {ParamsReportQuery} from '../usecases/charts/charts-report_employee_problems_by_dates'

export const mockParamsReportMecanicQuery = (): ParamsQuery => ({
  data: {
    initial_date: '01/01/2021',
    end_date: '31/08/2021',
  },
})

export const mockParamsReportEmployeeProblemQuery = (): ParamsReportQuery => ({
  data: {
    initial_date: '01/01/2021',
    end_date: '31/08/2021',
    employee_id: 1,
    employee_type: 'driver',
  },
})
