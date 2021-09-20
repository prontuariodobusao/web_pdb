import {ReportOrderByMecanic} from '../../models/charts-model'

export type ParamsDatesReport = {
  initial_date: string
  end_date: string
}

export type ParamsQuery = {
  data: ParamsDatesReport
}

export interface ChartsReportMecanicByDates {
  post: (params: ParamsQuery) => Promise<ReportOrderByMecanic>
}
