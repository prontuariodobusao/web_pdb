import React, {createContext, ReactNode, useReducer} from 'react'
import {DataTableState} from './states/datatable-state'
import {DataTableReducer} from './reducers/datatable-reducer'
import {
  DataTableParams,
  RemoteDataTable,
  ResponseDataTableModel,
} from '../../domain/usecases/remote-datatable'

type DataTableData = {
  state: DataTableState
  initializeDataTable: (
    request: RemoteDataTable,
    fields: Record<string, unknown>,
    idField: string,
  ) => void
  sort: () => void
  previousPage: () => void
  nextPage: () => void
  ellipLeft: () => void
  goToPage: () => void
  ellipRight: () => void
  searchTable: () => void
  changePerPage: () => void
}

const initialState: DataTableState = {
  draw: 0,
  page: 1,
  perPage: 5,
  data: [],
  loading: true,
  ajax: '',
  totalRecords: 0,
  fields: {},
  idField: '',
  sortField: null,
  sortDirection: null,
  searchValue: '',
  messageError: '',
}

const DataTableContext = createContext<DataTableData>({} as DataTableData)

export const DataTableContextProvider: React.FC = ({children}: any) => {
  const [state, dispatch] = useReducer(DataTableReducer, initialState)

  const requestData = async (
    request: RemoteDataTable,
    params: DataTableParams,
  ): Promise<ResponseDataTableModel | string> => {
    try {
      const respose = await request.datatable({
        draw: 1,
        page: params.page,
        per_page: params.per_page,
        sort_field: params.sort_field,
        sort_direction: params.sort_direction,
        search_value: params.search_value,
      })
      return respose
    } catch (error) {
      console.error(error)
      return 'Não possível realizar a ação'
    }
  }

  const initializeDataTable = async (
    request: RemoteDataTable,
    fields: Record<string, unknown>,
    idField: string,
  ) => {
    const {draw, page, perPage, sortField, sortDirection, searchValue} = state
    const response = (await requestData(request, {
      draw,
      page,
      per_page: perPage,
      sort_field: sortField,
      sort_direction: sortDirection,
      search_value: searchValue,
    })) as ResponseDataTableModel
    dispatch({
      type: 'initialize_table',
      payload: {
        data: response.data,
        ajax: '',
        totalRecords: response.totalRecords,
        fields: fields,
        idField: idField,
        perPage: 10,
      },
    })
  }

  const sort = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const previousPage = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const nextPage = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const ellipLeft = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const ellipRight = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const goToPage = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const searchTable = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const changePerPage = () => {
    dispatch({type: 'sort_table', payload: ''})
  }

  const contextValues = {
    initializeDataTable,
    sort,
    previousPage,
    nextPage,
    ellipLeft,
    goToPage,
    ellipRight,
    searchTable,
    changePerPage,
    state,
  }

  return (
    <DataTableContext.Provider value={contextValues}>
      {children}
    </DataTableContext.Provider>
  )
}

export default DataTableContext
