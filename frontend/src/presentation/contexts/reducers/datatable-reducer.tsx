import {DataTableState} from '../states/datatable-state'
import * as actionType from './actions'

type ActionProps = {
  type: string
  payload: any
}

export const DataTableReducer = (
  state: DataTableState,
  action: ActionProps,
): DataTableState => {
  switch (action.type) {
    case actionType.INITIALIZE_STATE:
      return {
        ...state,
        data: action.payload.data,
        loading: false,
        draw: 1,
        request: action.payload.request,
        totalRecords: action.payload.totalRecords,
        fields: action.payload.fields,
        idField: action.payload.idField,
        searchValue: '',
      }
    case actionType.TABLE_LOADING:
      return {
        ...state,
        loading: true,
        draw: state.draw + 1,
      }

    case actionType.SEARCH_TABLE:
      console.log(action.payload.page)
      return {
        ...state,
        loading: false,
        data: action.payload.data,
        totalRecords: action.payload.totalRecords,
        page: action.payload.page,
        searchValue: action.payload.searchValue,
      }
    case actionType.GO_TO_PAGE:
      return {
        ...state,
        loading: false,
        page: action.payload.page,
        data: action.payload.data,
      }
    case actionType.CHANGE_PER_PAGE:
      return {
        ...state,
        loading: false,
        perPage: action.payload.perPage,
        data: action.payload.data,
        page: 1,
      }
    case actionType.SORT_TABLE:
      return {
        ...state,
        loading: false,
        data: action.payload.data,
        sortField: action.payload.sortField,
        sortDirection: action.payload.sortDirection,
      }
    case actionType.NEXT_PAGE:
      return {
        ...state,
        data: action.payload.data,
        page: state.page + 1,
        loading: false,
      }
    case actionType.PREVIOUS_PAGE:
      return {
        ...state,
        data: action.payload.data,
        page: state.page - 1,
        loading: false,
      }
    default:
      return state
  }
}
