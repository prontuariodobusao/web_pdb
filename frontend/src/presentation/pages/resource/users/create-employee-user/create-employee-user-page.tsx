import React, {useState} from 'react'
import {CreateEmployeeUser} from '../../../../../domain/usecases/users/create-employee-user/create-empoyee-user'
import {Row, Col, Button, Alert, Form} from 'react-bootstrap'
import {UserWithPasswordModel} from '../../../../../domain/models/user-model'

type Props = {
  createEmployeeUser: CreateEmployeeUser
}

type StateComponent = {
  messageError: string
  infoSucess: boolean
  reload_user: UserWithPasswordModel
}

const CreateEmployeeUserPage: React.FC<Props> = ({
  createEmployeeUser,
}: Props) => {
  const [state, setState] = useState<StateComponent>({
    messageError: '',
    infoSucess: false,
    reload_user: {} as UserWithPasswordModel,
  })

  const handleCreateEmployeeUser = async () => {
    try {
      const response = await createEmployeeUser.create()
      setState({...state, reload_user: response, infoSucess: true})
    } catch (error) {
      console.error(error)
      setState({
        ...state,
        infoSucess: false,
        messageError: 'Não foi possível criar conta de usuário',
      })
    }
  }

  return (
    <>
      {state.infoSucess ? (
        <>
          <Row>
            <Col sm={12}>
              <Alert variant="success">Conta de usuário criada!</Alert>
            </Col>
          </Row>
          <Row>
            <Col sm="6">Matrícula para login de usuário</Col>
          </Row>
          <Row>
            <Col sm="6">
              <Form.Control
                plaintext
                readOnly
                defaultValue={state.reload_user.user.data.username}
              />
            </Col>
          </Row>
          <Row>
            <Col sm="6">Senha de primeiro acesso</Col>
          </Row>
          <Row>
            <Col sm="6">
              <Form.Control
                plaintext
                readOnly
                defaultValue={state.reload_user.password}
              />
            </Col>
          </Row>
        </>
      ) : (
        <Row>
          {state.messageError && (
            <Col sm={12}>
              <Alert variant="danger">{state.messageError}</Alert>
            </Col>
          )}
          <Col sm={12}>
            <h5>Este funcionário não possui conta de usuário!</h5>
          </Col>
          <Col>
            <Button
              className="btn button-plus label"
              onClick={handleCreateEmployeeUser}>
              <i className="feather icon-user-plus" /> Cadastrar Conta de
              Usuário
            </Button>
          </Col>
        </Row>
      )}
    </>
  )
}

export default CreateEmployeeUserPage
