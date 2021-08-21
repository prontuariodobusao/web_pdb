import {DataTableState} from '../states/datatable-state'
import * as actionType from './actions'

export const DataTableReducer = (state: DataTableState, action: any): any => {
  switch (action.type) {
    case actionType.TABLE_LOADING:
      return {
        ...state,
        loading: true,
        draw: state.draw + 1,
      }

    case actionType.SEARCH_TABLE:
      return {
        ...state,
        loading: false,
        data: action.data,
        totalRecords: action.totalRecords,
        page: action.page,
        searchValue: action.searchValue,
      }
    case actionType.GO_TO_PAGE:
      return {
        ...state,
        loading: false,
        page: action.page,
        data: action.data,
      }
    case actionType.CHANGE_PER_PAGE:
      return {
        ...state,
        loading: false,
        perPage: action.perPage,
        data: action.data,
        page: 1,
      }
    case actionType.SORT_TABLE:
      return {
        ...state,
        loading: false,
        data: action.data,
        sortField: action.sortField,
        sortDirection: action.sortDirection,
      }
    case actionType.INITIALIZE_STATE:
      return {
        ...state,
        data: action.data,
        loading: false,
        draw: 1,
        ajax: action.ajax,
        totalRecords: action.totalRecords,
        fields: action.fields,
        idField: action.idField,
        searchValue: '',
      }
    case actionType.NEXT_PAGE:
      return {
        ...state,
        data: action.data,
        page: state.page + 1,
        loading: false,
      }
    case actionType.PREVIOUS_PAGE:
      return {
        ...state,
        data: action.data,
        page: state.page - 1,
        loading: false,
      }
    default:
      return state
  }
}
