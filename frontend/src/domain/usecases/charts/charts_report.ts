import {ReportChartModel} from '../../models/charts-model'

export interface ChartsReport {
  get: () => Promise<ReportChartModel>
}
