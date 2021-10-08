import React, {useState, useEffect} from 'react'
import {PanelOrders} from '../../../domain/usecases/orders/panel-orders'
import {OrderPanelModel} from '../../../domain/models/order-model'
import {Table, Row, Col, Card, Spinner} from 'react-bootstrap'
import {choseImgCategory} from '../../helpers'

type Props = {
  panelOrders: PanelOrders
}

const PanelMecanicOrders: React.FC<Props> = ({panelOrders}: Props) => {
  const [loading, setLoading] = useState(true)
  const [state, setState] = useState<OrderPanelModel>({} as OrderPanelModel)

  const loadOrders = async (): Promise<void> => {
    try {
      const response = await panelOrders.get()
      setState(response)
    } catch (error) {
      console.error(error)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    loadOrders()
  }, [])

  return (
    <Row>
      <Col md={12}>
        <Card>
          <Card.Header>
            <Card.Title as="h5">Ordens de serviço</Card.Title>
          </Card.Header>
          <Card.Body>
            <Table responsive>
              <thead>
                <tr>
                  <th></th>
                  <th>Nº da OS</th>
                  <th>PROBLEMA</th>
                  <th>MECÂNICO</th>
                  <th>SOLICITANTE</th>
                  <th>STATUS</th>
                  <th>DESCRIÇÃO</th>
                </tr>
              </thead>
              <tbody>
                {loading ? (
                  <Spinner animation="grow" variant="info" />
                ) : (
                  <>
                    {state.data.map(order => (
                      <tr key={order.id}>
                        <td>
                          <img
                            style={{width: '40px'}}
                            src={choseImgCategory(order.category_id)}
                          />
                        </td>
                        <td>{order.reference}</td>
                        <td>{order.problem_description}</td>
                        <td>{order.mecanic}</td>
                        <td>{order.owner}</td>
                        <td>{order.status}</td>
                        <td>{order.description}</td>
                      </tr>
                    ))}
                  </>
                )}
              </tbody>
            </Table>
          </Card.Body>
        </Card>
      </Col>
    </Row>
  )
}

export default PanelMecanicOrders
