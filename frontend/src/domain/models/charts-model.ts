export type ChartModel = {
  name: string
  y: number
}

export type ReportChartModel = {
  qtds: {
    total: number
    os_waiting: number
    os_maintenance: number
    os_canceled: number
    os_finish: number
  }
  categories: ChartModel[]
  problems: ChartModel[]
}
