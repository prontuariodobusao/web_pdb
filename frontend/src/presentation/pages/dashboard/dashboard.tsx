import React, {useState, useEffect} from 'react'
import {Row, Col, Card, Spinner} from 'react-bootstrap'
import {HiPierChart, HiBarChart} from '../../components'
import {ChartsReport} from '../../../domain/usecases/charts/charts_report'
import {ReportChartModel} from '../../../domain/models/charts-model'
import {SpanNumber, SpanText} from './styles'

type Props = {
  chartsReport: ChartsReport
}

const Dashboard: React.FC<Props> = ({chartsReport}: Props) => {
  const [loading, setLoading] = useState(true)
  const [state, setState] = useState<ReportChartModel>({} as ReportChartModel)

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

  return (
    <>
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
              <h5>FInalizada</h5>
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
                <HiPierChart data={state.categories} />
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
                <HiBarChart data={state.problems} />
              )}
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default Dashboard
