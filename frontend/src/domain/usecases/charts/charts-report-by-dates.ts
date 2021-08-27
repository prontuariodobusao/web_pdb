import {ReportModel} from '../../models/charts-model'

export type ParamsQuery = {
  data: {
    type_report: number
    initial_date: string
    end_date: string
  }
}

export interface ChartsReportByDates {
  post: (params: ParamsQuery) => Promise<ReportModel>
}
