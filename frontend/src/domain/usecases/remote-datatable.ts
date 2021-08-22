export type DataTableParams = {
  draw: number
  page: number
  per_page: number
  sort_field?: any
  sort_direction: string
  search_value?: string
}

export type ResponseDataTableModel = {
  draw: number
  totalRecords: number
  data: any[]
}

export interface RemoteDataTable {
  datatable: (params: DataTableParams) => Promise<ResponseDataTableModel>
}
