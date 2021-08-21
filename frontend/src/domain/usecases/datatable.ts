export type DataTableParams = {
  draw: number
  page: number
  per_page: number
  sort_field?: any
  sort_direction: string
  search_value?: string
}

export interface DataTable<T> {
  datatable: (params: DataTableParams) => Promise<T>
}
