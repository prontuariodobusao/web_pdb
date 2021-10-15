import React, {useState, useEffect, ReactNode} from 'react'
import {Row, Col, Card, Spinner, Table} from 'react-bootstrap'
import {
  HiPierChart,
  HiBarChart,
  VerticallyCenteredModal,
  VehiclesRevisionsTable,
} from '../../components'
import {ChartsReport} from '../../../domain/usecases/charts/charts_report'
import {ReportChartModel} from '../../../domain/models/charts-model'
import {SpanNumber, SpanText} from './styles'

type Props = {
  chartsReport: ChartsReport
}

type StateModal = {
  title: string
  content?: ReactNode
  modalShow: boolean
}

const Dashboard: React.FC<Props> = ({chartsReport}: Props) => {
  const [loading, setLoading] = useState(true)
  const [state, setState] = useState<ReportChartModel>({} as ReportChartModel)
  const [infoModal, setInfoModal] = useState<StateModal>({} as StateModal)

  const loadCharts = async (): Promise<void> => {
    try {
      const response = await chartsReport.get()
      setState(response)
      setLoading(false)
    } catch (error) {
      console.error(error)
    }
  }

  useEffect(() => {
    loadCharts()
  }, [])

  const infoVehiclesRevision = (): void => {
    setInfoModal({
      title: 'Veiculos que precisam de revisão',
      content: (
        <VehiclesRevisionsTable data={state.vehicles_to_revision_change} />
      ),
      modalShow: true,
    })
  }

  const infoVehiclesOilChange = (): void => {
    setInfoModal({
      title: 'Veiculos que precisam de troca de óleo',
      content: <VehiclesRevisionsTable data={state.vehicles_to_oil_change} />,
      modalShow: true,
    })
  }

  const infoVehiclesTireChange = (): void => {
    setInfoModal({
      title: 'Veiculos que precisam de revisão de Pneus',
      content: <VehiclesRevisionsTable data={state.vehicles_to_tire_change} />,
      modalShow: true,
    })
  }

  return (
    <>
      <VerticallyCenteredModal
        title={infoModal.title}
        show={infoModal.modalShow}
        onHide={() => setInfoModal({...infoModal, modalShow: false})}>
        {infoModal.content}
      </VerticallyCenteredModal>
      <Row>
        <Col md={6}>
          <SpanText>Total de OS</SpanText>
        </Col>
      </Row>
      <Row>
        <Col md={6}>
          {loading ? (
            <Spinner animation="grow" variant="info" />
          ) : (
            <>
              <SpanNumber>{state.qtds.total}</SpanNumber>
            </>
          )}
        </Col>
      </Row>
      <Row>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5>Pendente</h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-yellow f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span className="m-b-0 card-number text-c-yellow ">
                        {state.qtds.os_waiting}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5>Manutenção</h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-blue f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span className="m-b-0 card-number text-c-blue ">
                        {state.qtds.os_maintenance}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5>Cancelada</h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-red f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span className="m-b-0 card-number text-c-red ">
                        {state.qtds.os_canceled}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5>Finalizada</h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-green f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span className="m-b-0 card-number text-c-green ">
                        {state.qtds.os_finish}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>
      <Row>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5 className="f-13">Tempo médio (em dias) de manutenção </h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-info f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span className="m-b-0 card-number text-c-info">
                        {state.qtds.os_down_time}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5 className="f-13">Veículos que precisam de revisão </h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-green-white f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span
                        className="m-b-0 card-number text-c-green-white indicator"
                        onClick={infoVehiclesRevision}>
                        {state.qtds.vehicles_to_revision_change}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5 className="f-13">Veículos que precisam de troca de óleo </h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-light-pink f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span
                        className="m-b-0 card-number text-c-light-pink indicator"
                        onClick={infoVehiclesOilChange}>
                        {state.qtds.vehicles_to_oil_change}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
        <Col md={6} xl={3}>
          <Card>
            <Card.Body>
              <h5 className="f-13">
                Veículos que precisam de revisão de pneu{' '}
              </h5>
              <div className="row d-flex align-items-center">
                <div className="col-6">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="ion ion-document-text text-c-dark-blue f-70 m-r-5" />
                  </h3>
                </div>

                <div className="col-6 text-right">
                  {loading ? (
                    <Spinner animation="grow" variant="info" />
                  ) : (
                    <>
                      <span
                        className="m-b-0 card-number text-c-dark-blue indicator"
                        onClick={infoVehiclesTireChange}>
                        {state.qtds.vehicles_to_tire_change}
                      </span>
                    </>
                  )}
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>
      <Row>
        <Col md={6}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">
                Veículos em manutenção por categorias
              </Card.Title>
            </Card.Header>
            <Card.Body>
              {loading ? (
                <Spinner animation="grow" variant="info" />
              ) : (
                <HiPierChart data={state.categories} title="Categorias" />
              )}
            </Card.Body>
          </Card>
        </Col>
        <Col md={6}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">
                Veículos em manutenção por problemas
              </Card.Title>
            </Card.Header>
            <Card.Body>
              {loading ? (
                <Spinner animation="grow" variant="info" />
              ) : (
                <HiBarChart data={state.problems} title="Problemas" />
              )}
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default Dashboard
