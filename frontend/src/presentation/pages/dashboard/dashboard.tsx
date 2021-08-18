import React from 'react'
import {Row, Col, Card} from 'react-bootstrap'

const Dashboard: React.FC = () => {
  return (
    <>
      <Row>
        <Col md={6} xl={4}>
          <Card>
            <Card.Body>
              <h6 className="mb-4">Daily Sales</h6>
              <div className="row d-flex align-items-center">
                <div className="col-9">
                  <h3 className="f-w-300 d-flex align-items-center m-b-0">
                    <i className="feather icon-arrow-up text-c-green f-30 m-r-5" />{' '}
                    $249.95
                  </h3>
                </div>

                <div className="col-3 text-right">
                  <p className="m-b-0">50%</p>
                </div>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default Dashboard
