export type VehicleModel = {
  id: number
  car_line_id: number
  km: number
  car_number: string
  oil_date: string
  tire_date: string
  revision_date: string
}

export type VehicleDataModel = {
  data: {
    id: number
    car_line_id: number
    km: number
    car_number: string
    oil_date: string
    tire_date: string
    revision_date: string
  }
  meta: {
    links: {
      self: string
    }
  }
}

export type VehicleRevisionModel = {
  id: number
  number: string
  current_km: number
  next_change: number
}
