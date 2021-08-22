import React, {createContext, ReactNode, useReducer} from 'react'
import {DataTableState} from './states/datatable-state'
import {DataTableReducer} from './reducers/datatable-reducer'

type DataTableData = {
  state: DataTableState
  initializeDataTable: () => void
  sort: () => void
  previousPage: () => void
  nextPage: () => void
  ellipLeft: () => void
  goToPage: () => void
  ellipRight: () => void
  searchTable: () => void
  changePerPage: () => void
}

const DataTableContext = createContext<DataTableData>({} as DataTableData)

const initialState = {
  draw: 0,
  page: 1,
  perPage: 10,
  data: [],
  loading: true,
  ajax: '',
  totalRecords: 0,
  fields: {},
  idField: '',
  sortField: null,
  sortDirection: null,
  searchValue: '',
}

export type Props = {
  children: ReactNode
}

export const DataTableContextProvider = ({children}: Props): ReactNode => {
  const [state, dispatch] = useReducer(DataTableReducer, initialState)

  const initializeDataTable = (payload: DataTableState) => {
    dispatch({type: 'initialize_table', payload})
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
    ...state,
  }

  return (
    <DataTableContext.Provider value={contextValues}>
      {children}
    </DataTableContext.Provider>
  )
}

export default DataTableContext
