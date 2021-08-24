/* eslint-disable react/display-name */
import React from 'react'
import {Row, Col, Card, Button} from 'react-bootstrap'
import {DataTable} from '../../../../components'
import {EmployeeDataTable} from '../../../../../domain/usecases/employees/employee-datatable'

type Props = {
  remoteEmployeeDataTable: EmployeeDataTable
}

const EmployeesDt: React.FC<Props> = ({remoteEmployeeDataTable}: Props) => {
  return (
    <>
      <Row>
        <Col md={12}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Lista de Funcionários</Card.Title>
            </Card.Header>
            <Card.Body>
              <DataTable
                remoteRequestRecords={remoteEmployeeDataTable}
                fields={{
                  name: 'Nome',
                  identity: 'Matricula',
                  confirmation: 'Confirmação de Login',
                  occupation: 'Cargo',
                  cell: () => (
                    <Button className="label theme-bg text-white f-12 button-table">
                      Editar
                    </Button>
                  ),
                }}
                idField="id"
              />
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default EmployeesDt
