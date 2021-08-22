export type DataTableState = {
  draw: number
  page: number
  perPage: number
  data: any
  loading: boolean
  request: any
  totalRecords: number
  fields: any
  idField: string
  sortField: any
  sortDirection: any
  searchValue: string
  messageError: string
}
