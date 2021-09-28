import {ReportModel} from '../../models/charts-model'

export type ParamsDatesReportEmployee = {
  initial_date: string
  end_date: string
  employee_id: number
  employee_type: string
}

export type ParamsReportQuery = {
  data: ParamsDatesReportEmployee
}

export interface ChartsReportEmployeeProblemsByDates {
  post: (params: ParamsReportQuery) => Promise<ReportModel>
}
