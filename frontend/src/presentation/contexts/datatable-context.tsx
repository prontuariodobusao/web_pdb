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
  sort: (field: number, direction: string) => void
  previousPage: () => void
  nextPage: () => void
  ellipLeft: () => void
  goToPage: (page: number) => void
  ellipRight: () => void
  searchTable: (schValue: any) => void
  changePerPage: (perPage: number) => void
}

const initialState: DataTableState = {
  draw: 0,
  page: 1,
  perPage: 5,
  data: [],
  loading: true,
  request: null,
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
        request,
        totalRecords: response.totalRecords,
        fields: fields,
        idField: idField,
        perPage: 10,
      },
    })
  }

  const searchTable = async (searchValue: any) => {
    if (searchValue.length < 3) searchValue = ''
    dispatch({type: 'table_loading', payload: {}})
    const {request, draw, perPage, sortField, sortDirection} = state
    const response = (await requestData(request, {
      draw,
      per_page: perPage,
      sort_field: sortField,
      sort_direction: sortDirection,
      search_value: searchValue,
    })) as ResponseDataTableModel
    const newPage = 1
    dispatch({
      type: 'sort_table',
      payload: {
        data: response.data,
        request,
        totalRecords: response.totalRecords,
        page: newPage,
      },
    })
  }

  const goToPage = async (page: number) => {
    console.log(page)
    const {
      request,
      draw,
      perPage,
      totalRecords,
      sortDirection,
      sortField,
      searchValue,
    } = state
    if (page > 0 && page <= Math.ceil(totalRecords / perPage)) {
      dispatch({type: 'table_loading', payload: {}})
      const response = (await requestData(request, {
        draw,
        page,
        per_page: perPage,
        sort_field: sortField,
        sort_direction: sortDirection,
        search_value: searchValue,
      })) as ResponseDataTableModel
      dispatch({
        type: 'go_to_page',
        payload: {
          data: response.data,
          page,
        },
      })
    }
  }
  const previousPage = async () => {
    const {
      request,
      draw,
      page,
      perPage,
      sortDirection,
      sortField,
      searchValue,
    } = state

    if (page > 1) {
      dispatch({type: 'table_loading', payload: {}})
      const newPage = page - 1
      const response = (await requestData(request, {
        draw,
        page: newPage,
        per_page: perPage,
        sort_field: sortField,
        sort_direction: sortDirection,
        search_value: searchValue,
      })) as ResponseDataTableModel
      dispatch({
        type: 'previous_page',
        payload: {
          data: response.data,
        },
      })
    }
  }

  const nextPage = async () => {
    const {
      request,
      draw,
      page,
      perPage,
      totalRecords,
      sortDirection,
      sortField,
      searchValue,
    } = state

    if (page * perPage + 1 <= totalRecords) {
      dispatch({type: 'table_loading', payload: {}})
      const newPage = page + 1
      const response = (await requestData(request, {
        draw,
        page: newPage,
        per_page: perPage,
        sort_field: sortField,
        sort_direction: sortDirection,
        search_value: searchValue,
      })) as ResponseDataTableModel
      dispatch({
        type: 'next_page',
        payload: {
          data: response.data,
        },
      })
    }
  }

  const ellipLeft = async () => {
    const {
      request,
      draw,
      page,
      perPage,
      sortDirection,
      sortField,
      searchValue,
    } = state
    if (page >= 4) {
      dispatch({type: 'table_loading', payload: {}})
      const newPage = page - 4
      const response = (await requestData(request, {
        draw,
        page: newPage,
        per_page: perPage,
        sort_field: sortField,
        sort_direction: sortDirection,
        search_value: searchValue,
      })) as ResponseDataTableModel
      dispatch({
        type: 'go_to_page',
        payload: {
          data: response.data,
          page: newPage,
        },
      })
    }
  }

  const ellipRight = async () => {
    const {
      request,
      draw,
      page,
      perPage,
      totalRecords,
      sortDirection,
      sortField,
      searchValue,
    } = state
    const totalPages = Math.ceil(totalRecords / perPage)
    if (totalPages - 4 >= page) {
      dispatch({type: 'table_loading', payload: {}})
      const newPage = page + 4
      const response = (await requestData(request, {
        draw,
        page: newPage,
        per_page: perPage,
        sort_field: sortField,
        sort_direction: sortDirection,
        search_value: searchValue,
      })) as ResponseDataTableModel
      dispatch({
        type: 'go_to_page',
        payload: {
          data: response.data,
          page: newPage,
        },
      })
    }
  }

  const changePerPage = async (perPage: number) => {
    const {request, draw, sortDirection, sortField, searchValue} = state
    const newPerPage = Number(perPage)
    if ([5, 10, 15].includes(newPerPage)) {
      dispatch({type: 'table_loading', payload: {}})
      const response = (await requestData(request, {
        draw,
        page: 1,
        per_page: newPerPage,
        sort_field: sortField,
        sort_direction: sortDirection,
        search_value: searchValue,
      })) as ResponseDataTableModel
      dispatch({
        type: 'change_per_page',
        payload: {
          data: response.data,
          perPage: newPerPage,
        },
      })
    }
  }

  const sort = async (field: number, direction = 'asc') => {
    const {request, draw, perPage, page, fields, searchValue} = state
    if (Object.values(fields).includes(field) || field === null) {
      dispatch({type: 'table_loading', payload: {}})
      const response = (await requestData(request, {
        draw,
        page,
        per_page: perPage,
        sort_field: field,
        sort_direction: direction,
        search_value: searchValue,
      })) as ResponseDataTableModel
      dispatch({
        type: 'sort_table',
        payload: {
          data: response.data,
          sortField: field,
          sortDirection: direction,
        },
      })
    }
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
