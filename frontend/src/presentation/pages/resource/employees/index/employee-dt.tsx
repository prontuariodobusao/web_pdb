/* eslint-disable react/display-name */
import React, {useState} from 'react'
import {Row, Col, Card, Button} from 'react-bootstrap'
import {DataTable, VerticallyCenteredModal} from '../../../../components'
import {EmployeeDataTable} from '../../../../../domain/usecases/employees'
import {
  CreateEmployeeForm,
  CreateEmployeeEdit,
} from '../../../../../main/factories'

type Props = {
  remoteEmployeeDataTable: EmployeeDataTable
}

const EmployeesDt: React.FC<Props> = ({remoteEmployeeDataTable}: Props) => {
  const [modalShow, setModalShow] = useState(false)
  const [stateEdit, setStateEdit] = useState({
    modalEdit: false,
    idResource: 0,
  })

  const showModalEdit = (id: number): void => {
    setStateEdit({modalEdit: true, idResource: id})
    setModalShow(true)
  }

  const showModalCreate = (): void => {
    setStateEdit({modalEdit: false, idResource: 0})
    setModalShow(true)
  }

  return (
    <>
      <Row>
        <Col>
          <Button
            className="btn button-plus label"
            onClick={() => showModalCreate()}>
            <i className="feather icon-user-plus" /> Cadastrar Funcionário
          </Button>
        </Col>
      </Row>
      <VerticallyCenteredModal
        title={
          stateEdit.modalEdit ? 'Editar Funcionário' : 'Cadastrar Funcionário'
        }
        show={modalShow}
        onHide={() => setModalShow(false)}>
        {stateEdit.modalEdit ? (
          <>
            <CreateEmployeeEdit idParams={String(stateEdit.idResource)} />
          </>
        ) : (
          <CreateEmployeeForm />
        )}
      </VerticallyCenteredModal>
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
                  cell: (id: number) => (
                    <Button
                      className="label theme-bg text-white f-12 button-table"
                      onClick={() => showModalEdit(id)}>
                      <i className="feather icon-edit" /> Editar
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
