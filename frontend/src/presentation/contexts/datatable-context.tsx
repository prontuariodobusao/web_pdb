import React, {createContext, ReactNode, useReducer} from 'react'
import {DataTableState} from './states/datatable-state'
import {DataTableReducer} from './reducers/datatable-reducer'

const DataTableContext = createContext<DataTableState>({} as DataTableState)

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

const DataTableContextProvider = ({children}: Props): ReactNode => {
  const [state, dispatch] = useReducer(DataTableReducer, initialState)

  const initializeDataTable = (payload: DataTableState) => {
    dispatch({type: 'initialize_table', payload})
  }

  const contextValues = {
    initializeDataTable,
    ...state,
  }

  return (
    <DataTableContext.Provider value={contextValues}>
      {children}
    </DataTableContext.Provider>
  )
}

export default DataTableContextProvider
