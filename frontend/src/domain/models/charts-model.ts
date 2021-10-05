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
    os_down_time: number
    vehicles_to_oil_change: number
    vehicles_to_tire_change: number
    vehicles_to_revision_change: number
  }
  categories: ChartModel[]
  problems: ChartModel[]
}

export type ReportModel = {
  report: ChartModel[]
}

export type ReportOrderByMecanic = {
  orders_maintenance: ChartModel[]
  orders_finish: ChartModel[]
}
