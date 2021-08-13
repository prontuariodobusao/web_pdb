import React from 'react'
import {Card, Row, Col, Button} from 'react-bootstrap'
import Breadcrumb from '../../layouts/AdminLayout/Breadcrumb'
import logoPdb from '../../assets/images/logo-pdb.png'

const SignIn: React.FC = () => {
  return (
    <>
      <Breadcrumb />
      <div className="auth-wrapper">
        <div className="auth-content">
          <Card className="borderless text-center">
            <Card.Body>
              <div className="mb-4">
                <img src={logoPdb} style={{height: 'auto', width: '60%'}} />
              </div>
              <form>
                <div className="form-group mb-3">
                  <input
                    className="form-control"
                    placeholder="Matrícula"
                    name="email"
                    type="email"
                  />
                </div>
                <div className="form-group mb-4">
                  <input
                    className="form-control"
                    placeholder="Senha"
                    name="password"
                    type="password"
                  />
                </div>
                <Row>
                  <Col>
                    <Button
                      className="btn-block"
                      color="primary"
                      size="lg"
                      type="submit"
                      variant="primary">
                      Entrar
                    </Button>
                  </Col>
                </Row>
              </form>
            </Card.Body>
          </Card>
        </div>
      </div>
    </>
  )
}

export default SignIn
