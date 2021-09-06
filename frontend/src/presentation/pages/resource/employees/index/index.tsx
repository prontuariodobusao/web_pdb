import React, {useMemo, useState} from 'react'
import {Row, Col, Card, Table, Button} from 'react-bootstrap'
import {useTable, useGlobalFilter} from 'react-table'
import {GlobalFilter} from 'presentation/components'

const Employees: React.FC = () => {
  const DATA = [
    {
      identify: '123',
      name: 'Leanne Graham',
      occupation: 'Gerente',
      confirmation: 'Sim',
      id: 1,
    },
    {
      identify: '345',
      name: 'Ervin Howell',
      occupation: 'Motorista',
      confirmation: 'Sim',
      id: 2,
    },
    {
      identify: '789',
      name: 'Clementine Bauch',
      occupation: 'Gerent',
      confirmation: 'Sim',
      id: 3,
    },
    {
      identify: '1234',
      name: 'Julianne Uchoa',
      occupation: 'RH',
      confirmation: 'Sim',
      id: 4,
    },
  ]

  const COLUMNS = [
    {
      Header: 'Matricula',
      accessor: 'identify',
    },
    {
      Header: 'Nome',
      accessor: 'name',
    },
    {
      Header: 'Cargo',
      accessor: 'occupation',
    },
    {
      Header: 'Confirmado?',
      accessor: 'confirmation',
    },
    {
      Header: () => null,
      accessor: 'id',
      // eslint-disable-next-line react/display-name
      Cell: () => (
        <Button className="label theme-bg text-white f-12">Editar</Button>
      ),
    },
  ]
  const data = useMemo(() => DATA, [])
  const columns = useMemo<any>(() => COLUMNS, [])

  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
    state,
    setGlobalFilter,
  } = useTable({columns, data}, useGlobalFilter)

  const {globalFilter} = state

  return (
    <>
      <Row>
        <Col md={12}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Lista de Funcionários</Card.Title>
            </Card.Header>
            <Card.Body>
              <GlobalFilter
                globalFilter={globalFilter}
                setGlobalFilter={setGlobalFilter}
              />
              <Table responsive hover>
                <thead>
                  {headerGroups.map(headerGroup => (
                    <tr
                      {...headerGroup.getHeaderGroupProps()}
                      key={headerGroup.id}>
                      {headerGroup.headers.map(column => (
                        <th {...column.getHeaderProps()} key={column.id}>
                          {column.render('Header')}
                        </th>
                      ))}
                    </tr>
                  ))}
                </thead>
                <tbody {...getTableBodyProps()}>
                  {rows.map((row, i) => {
                    prepareRow(row)
                    return (
                      <tr {...row.getRowProps()} key={i}>
                        {row.cells.map(cell => {
                          return (
                            <td {...cell.getCellProps()} key={cell.row.id}>
                              {cell.render('Cell')}
                            </td>
                          )
                        })}
                      </tr>
                    )
                  })}
                </tbody>
              </Table>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default Employees
