import React, {useState, useEffect} from 'react'
import {AddOrRemoveRoles} from '../../../../../domain/usecases/users/add-or-remove-roles/add-or-remove-roles'
import {Row, Col, Button, Alert} from 'react-bootstrap'
import {UserDataModel, UserModel} from '../../../../../domain/models/user-model'
import {RoleModel} from '../../../../../domain/models/role-model'
import {getRoles} from '@testing-library/dom'

type Props = {
  addOrRemoveRoles: AddOrRemoveRoles
  user: UserModel
}

type StateComponent = {
  messageError: string
  infoSucess: boolean
  user: UserDataModel
  roleActive: boolean
}

const AddOrRemoveRolesPage: React.FC<Props> = ({
  addOrRemoveRoles,
  user,
}: Props) => {
  const [state, setState] = useState<StateComponent>({
    messageError: '',
    infoSucess: false,
    user: {} as UserDataModel,
    roleActive: true,
  })
  const [roleState, setRoleState] = useState({
    roles: [] as any,
    loading: true,
  })
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    setRoleState({...roleState, roles: user.roles})
  }, [])

  const handleAddOrRemoveRoles = async () => {
    const params = {
      data: {
        name: 'admin',
      },
    }
    try {
      const response = await addOrRemoveRoles.addOrRemove(params)
      setState({...state, user: response, infoSucess: true})
    } catch (error) {
      console.error(error)
      setState({
        ...state,
        infoSucess: false,
        messageError: 'Não foi possível alterar o nível',
      })
    }
  }

  const mainClassButton = (): string[] => {
    if (state.roleActive) return ['btn', 'button-plus', 'label']
    return ['btn', 'button-disable', 'label']
  }

  return (
    <>
      {state.infoSucess && (
        <>
          <Row>
            <Col sm={12}>
              <Alert variant="success">Nível de usuário redefinido!</Alert>
            </Col>
          </Row>
        </>
      )}
      <Row>
        {state.messageError && (
          <Col sm={12}>
            <Alert variant="danger">{state.messageError}</Alert>
          </Col>
        )}
        <Col>
          {loading && (
            <>
              <Button
                className={mainClassButton().join(' ')}
                onClick={handleAddOrRemoveRoles}>
                <i className="feather icon-users" /> Admin
              </Button>
              <Button
                className={mainClassButton().join(' ')}
                onClick={handleAddOrRemoveRoles}>
                <i className="feather icon-users" /> Visitante
              </Button>
              <Button
                className={mainClassButton().join(' ')}
                onClick={handleAddOrRemoveRoles}>
                <i className="feather icon-users" /> Editor
              </Button>
              <Button
                className={mainClassButton().join(' ')}
                onClick={handleAddOrRemoveRoles}>
                <i className="feather icon-users" /> Mobile
              </Button>
            </>
          )}
        </Col>
      </Row>
    </>
  )
}

export default AddOrRemoveRolesPage
