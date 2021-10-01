import {DataTable} from 'presentation/components'
import React, {useState} from 'react'
import {Row, Col, Card, Button} from 'react-bootstrap'
import {VehicleDataTable} from '../../../../../domain/usecases/vehicles/vehicle-datatable'

type Props = {
  remoteVehiclesDataTable: VehicleDataTable
}

const VehiclesDt: React.FC<Props> = ({remoteVehiclesDataTable}: Props) => {
  const [modalShow, setModalShow] = useState(false)
  const [stateEdit, setStateEdit] = useState({
    modalEdit: false,
    idResource: 0,
  })

  const showModalCreate = (): void => {
    setStateEdit({modalEdit: false, idResource: 0})
    setModalShow(true)
  }

  const showModalEdit = (id: number): void => {
    setStateEdit({modalEdit: true, idResource: id})
    setModalShow(true)
  }

  // const VehiclesDt: React.FC<Props> = ({remoteVehiclesDataTable}: Props) => {
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
                remoteRequestRecords={remoteVehiclesDataTable}
                fields={{
                  car_number: 'Número do carro',
                  km: 'Km atual',
                  oil_date: 'Data troca do óleo',
                  revision_date: 'Data de revisão',
                  tire_date: 'Data da troca de pneus',
                  break_predictability: 'Previsibilidade de quebra',
                  // name: 'Nome',
                  // identity: 'Matricula',
                  // confirmation: 'Confirmação de Login',
                  // occupation: 'Cargo',
                  // eslint-disable-next-line react/display-name
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

export default VehiclesDt
