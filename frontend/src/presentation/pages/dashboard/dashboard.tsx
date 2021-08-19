import React from 'react'
import {Row, Col, Card} from 'react-bootstrap'
import {PierBasicChart, BarBasicChart} from '../../components'

const Dashboard: React.FC = () => {
  return (
    <>
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
                  <span className="m-b-0 card-number text-c-yellow ">20</span>
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
                  <span className="m-b-0 card-number text-c-blue">20</span>
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
                  <span className="m-b-0 card-number text-c-red">20</span>
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
                  <span className="m-b-0 card-number text-c-green">20</span>
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
                Veículos em manutenção por problemas
              </Card.Title>
            </Card.Header>
            <Card.Body>
              <PierBasicChart />
            </Card.Body>
          </Card>
        </Col>
        <Col md={6}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">
                Veículos em manutenção por categorias
              </Card.Title>
            </Card.Header>
            <Card.Body>
              <BarBasicChart />
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default Dashboard
