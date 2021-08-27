import React from 'react'
import {Row, Col, Card} from 'react-bootstrap'

const ChartsByDatePage: React.FC = () => {
  return (
    <>
      <Row>
        <Col md={12}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">
                Informe o tipo de indicador e as datas
              </Card.Title>
            </Card.Header>
            <Card.Body></Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default ChartsByDatePage
