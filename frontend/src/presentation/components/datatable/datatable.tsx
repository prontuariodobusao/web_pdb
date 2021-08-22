import React, {useEffect, useContext, useState} from 'react'
import {RemoteDataTable} from '../../../domain/usecases/remote-datatable'
import {
  Table,
  Pagination,
  Col,
  FormGroup,
  FormControl,
  FormControlProps,
} from 'react-bootstrap'
import {DataTableContext} from '../../contexts'

import Loading from './datatable-loading'

const WAIT_INTERVAL = 1000
const ENTER_KEY = 13
const pageInputStyle = {
  marginLeft: '5px',
  marginRight: '5px',
}
const sortLinkStyle = {
  marginLeft: '10px',
  color: 'darkgray',
}

type Props = {
  remoteRequestRecords: RemoteDataTable
  fields: Record<string, unknown>
  idField: string
}

const DataTable: React.FC<Props> = ({
  remoteRequestRecords,
  fields,
  idField,
}: Props) => {
  const {
    initializeDataTable,
    sort,
    nextPage,
    previousPage,
    ellipLeft,
    goToPage,
    ellipRight,
    searchTable,
    changePerPage,
    state,
  } = useContext(DataTableContext)

  const [loading, setLoading] = useState(true)
  const [timer, setTimer] = useState(0)

  const loadData = async (): Promise<void> => {
    await initializeDataTable(remoteRequestRecords, fields, idField)
    setLoading(false)
  }

  useEffect(() => {
    loadData()
  }, [])

  const columnSize = () => {
    const tableSize = Object.keys(fields).length
    let colSize = Math.floor(12 / tableSize)
    if (colSize === 0) colSize = 1
    return 'col-md-' + colSize
  }

  const renderHead = () => {
    const keys = Object.keys(fields)
    const th = keys.map(key => {
      return (
        <th key={key} className={columnSize()}>
          {key}
          {/* <span>{renderSort(fields[key])}</span> */}
        </th>
      )
    })
    return (
      <thead>
        <tr>{th}</tr>
      </thead>
    )
  }

  const renderBody = () => {
    const values = Object.values(fields)
    const data = state.data
    const tr = data.map((datum: any) => {
      const td = values.map((field: any) => {
        const tdId = String(datum[idField]) + '-' + field
        return <td key={tdId}>{datum[field]}</td>
      })

      return <tr key={datum[idField]}>{td}</tr>
    })
    return <tbody>{tr}</tbody>
  }

  // const renderSort = (key: any) => {
  //   const ascActive = state.sortField === key && state.sortDirection === 'asc'
  //   const descActive = state.sortField === key && state.sortDirection === 'desc'
  //   const ascColor = ascActive ? 'black' : 'darkgray'
  //   const descColor = descActive ? 'black' : 'darkgray'
  //   return (
  //     <a
  //       style={sortLinkStyle}
  //       onClick={() => onSortClick(key, ascActive, descActive)}>
  //       <i
  //         className="feather icon-chevron-up"
  //         key={key + '-up'}
  //         style={{color: ascColor}}
  //       />
  //       <i
  //         className="feather icon-chevron-down"
  //         key={key + '-down'}
  //         style={{color: descColor}}
  //       />
  //     </a>
  //   )
  // }

  // const onSortClick = (field, ascActive, descActive) => {
  //   if (ascActive) {
  //     sort(field, 'desc')
  //   } else if (descActive) {
  //     sort(null)
  //   } else {
  //     sort(field, 'asc')
  //   }
  // }

  // const renderPageButtons = () => {
  //   const totalPages = getTotalPages()
  //   const page = state.page
  //   const previousActive = page > 1
  //   const nextActive = page < totalPages
  //   const previousLink = (
  //     <Pagination.Item
  //       disabled={!previousActive}
  //       key="prev"
  //       onClick={() => previousPage()}>
  //       Previous
  //     </Pagination.Item>
  //   )
  //   const nextLink = (
  //     <Pagination.Item
  //       disabled={!nextActive}
  //       key="next"
  //       onClick={() => nextPage()}>
  //       Next
  //     </Pagination.Item>
  //   )

  //   const links = []
  //   if (totalPages <= 10) {
  //     for (let i = 1; i <= totalPages; i++) {
  //       const active = page === i
  //       links.push(
  //         <Pagination.Item key={i} active={active}>
  //           {i}
  //         </Pagination.Item>,
  //       )
  //     }
  //   } else {
  //     if (page > 4)
  //       links.push(
  //         <Pagination.Ellipsis key="e-down" onClick={() => ellipLeft()} />,
  //       )
  //     for (let i = page - 8; i <= page + 8; i++) {
  //       const active = page === i
  //       if (i > 0 && i <= totalPages) {
  //         if (i < page - 3) {
  //           if (page + 4 <= totalPages && page - 4 >= 1) continue

  //           const leftPad = 7 - (totalPages - page)
  //           if (page - i <= leftPad) {
  //             links.push(
  //               <Pagination.Item
  //                 key={i}
  //                 onClick={() => goToPage(i)}
  //                 active={active}>
  //                 {i}
  //               </Pagination.Item>,
  //             )
  //           }
  //         } else if (i > page + 3) {
  //           if (totalPages >= page + 4 && page - 4 >= 1) continue

  //           const rightPad = 8 - page
  //           if (i - page <= rightPad) {
  //             links.push(
  //               <Pagination.Item
  //                 key={i}
  //                 onClick={() => goToPage(i)}
  //                 active={active}>
  //                 {i}
  //               </Pagination.Item>,
  //             )
  //           }
  //         } else {
  //           links.push(
  //             <Pagination.Item
  //               key={i}
  //               onClick={() => goToPage(i)}
  //               active={active}>
  //               {i}
  //             </Pagination.Item>,
  //           )
  //         }
  //       }
  //     }
  //     if (page <= totalPages - 4)
  //       links.push(
  //         <Pagination.Ellipsis key="e-up" onClick={() => ellipRight()} />,
  //       )
  //   }

  //   return (
  //     <div>
  //       <Pagination bsSize="small">
  //         {previousLink}
  //         {links}
  //         {nextLink}
  //       </Pagination>
  //     </div>
  //   )
  // }

  // const getTotalPages = () => {
  //   return Math.ceil(state.totalRecords / state.perPage)
  // }

  // const handlePageInput = event => {
  //   clearTimeout(this.timer)
  //   const newPage = Number(event.target.value)
  //   if (newPage < 1 || newPage > getTotalPages()) {
  //     event.target.value = ''
  //     return
  //   }
  //   event.persist()
  //   this.timer = setTimeout(() => {
  //     if (event.target !== null) goToPage(event.target.value)
  //     event.target.placeholder = event.target.value
  //     event.target.value = ''
  //   }, WAIT_INTERVAL)
  // }

  // const handlePageInputKeyDown = event => {
  //   const value = event.target.value
  //   const newPage = Number(event.target.value)

  //   if (newPage < 1 || newPage > getTotalPages()) {
  //     event.target.value = ''
  //     return
  //   }
  //   if (event.keyCode === ENTER_KEY) {
  //     clearTimeout(this.timer)
  //     goToPage(value)
  //     event.target.placeholder = value
  //     event.target.value = ''
  //   }
  // }

  // const renderLoading = () => {
  //   if (!state.loading) return
  //   return <Loading />
  // }

  const handleSearchChange = (event: any) => {
    const value = event.target.value
    window.clearTimeout(timer)
    const newTimer = window.setTimeout(() => {
      if (value !== null) searchTable(value)
    }, WAIT_INTERVAL)
    setTimer(newTimer)
  }

  const renderSearch = () => {
    return (
      <FormGroup>
        <FormControl
          type="text"
          placeholder="Search"
          onChange={handleSearchChange.bind(this)}
        />
      </FormGroup>
    )
  }

  return (
    <div className="table-wrapper">
      <Col xs={8} md={4}>
        {renderSearch()}
      </Col>
      {state.loading ? (
        <span>Carregando...</span>
      ) : (
        <Table responsive hover>
          {renderHead()}
          {renderBody()}
        </Table>
      )}
      {/* {renderLoading()} */}
      {/* <Col xs={8}>
        <div>
          Page
          <span>
            <input
              type="text"
              style={pageInputStyle}
              className="text-center page-input"
              size={2}
              onChange={event => handlePageInput(event)}
              onKeyDown={event => handlePageInputKeyDown(event)}
              placeholder={state.page}
            />
            of {getTotalPages()}
          </span>
        </div>
        {renderPageButtons()}
      </Col> */}
      {/* <Col xs={4} className="text-right">
        <div>
          <span>
            <select
              style={pageInputStyle}
              value={state.perPage}
              onChange={event => changePerPage(event.target.value)}>
              <option value={10}>10</option>
              <option value={25}>25</option>
              <option value={50}>50</option>
              <option value={100}>100</option>
            </select>
            per page
          </span>
        </div>
      </Col> */}
    </div>
  )
}

export default DataTable
