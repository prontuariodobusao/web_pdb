export type DataTableState = {
  draw: number
  page: number
  perPage: number
  data: any
  loading: boolean
  ajax: string
  totalRecords: number
  fields: any
  idField: string
  sortField: any
  sortDirection: any
  searchValue: string
}
