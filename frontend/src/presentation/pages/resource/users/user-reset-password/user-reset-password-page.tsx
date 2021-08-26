import React, {useState} from 'react'
import {ResetPassword} from '../../../../../domain/usecases/users/reset-password/reset-password'
import {Row, Col, Button, Alert, Form} from 'react-bootstrap'
import {UserWithPasswordModel} from '../../../../../domain/models/user-model'

type Props = {
  resetPassword: ResetPassword
}

type StateComponent = {
  messageError: string
  infoSucess: boolean
  reload_user: UserWithPasswordModel
}

const UserResetPasswordPage: React.FC<Props> = ({resetPassword}: Props) => {
  const [state, setState] = useState<StateComponent>({
    messageError: '',
    infoSucess: false,
    reload_user: {} as UserWithPasswordModel,
  })

  const handleResetPassword = async () => {
    try {
      const response = await resetPassword.resetPassword()
      setState({...state, reload_user: response, infoSucess: true})
    } catch (error) {
      console.error(error)
      setState({
        ...state,
        infoSucess: false,
        messageError: 'Não foi possível resetar a senha',
      })
    }
  }

  return (
    <>
      {state.infoSucess ? (
        <>
          <Row>
            <Col sm={12}>
              <Alert variant="success">
                Senha de conta de usuário redefinida!
              </Alert>
            </Col>
          </Row>
          <Row>
            <Col sm="6">Nova Senha de primeiro acesso</Col>
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
          <Col>
            <Button
              className="btn button-plus label"
              onClick={handleResetPassword}>
              <i className="feather icon-lock" /> Resetar Senha
            </Button>
          </Col>
        </Row>
      )}
    </>
  )
}

export default UserResetPasswordPage
