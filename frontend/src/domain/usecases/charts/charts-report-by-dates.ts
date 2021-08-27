import {ReportModel} from '../../models/charts-model'

export type ParamsDatesReport = {
  type_report: number
  initial_date: string
  end_date: string
}

export type ParamsQuery = {
  data: ParamsDatesReport
}

export interface ChartsReportByDates {
  post: (params: ParamsQuery) => Promise<ReportModel>
}
