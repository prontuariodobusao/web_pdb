import React, {useState, useEffect} from 'react'
import {AddOrRemoveRoles} from '../../../../../domain/usecases/users/add-or-remove-roles/add-or-remove-roles'
import {Row, Col, Button, Alert} from 'react-bootstrap'
import {UserModel} from '../../../../../domain/models/user-model'
import {RoleModel} from '../../../../../domain/models/role-model'
import {SpinnerBT} from '../../../../components'

type Props = {
  addOrRemoveRoles: AddOrRemoveRoles
  user: UserModel
}

type StateComponent = {
  messageError: string
  infoSucess: boolean
  user: UserModel
  roleActive: boolean
  cssClass: string[]
}

const AddOrRemoveRolesPage: React.FC<Props> = ({
  addOrRemoveRoles,
  user,
}: Props) => {
  const [state, setState] = useState<StateComponent>({
    messageError: '',
    infoSucess: false,
    user,
    roleActive: true,
    cssClass: [''],
  })
  const [roleState, setRoleState] = useState({
    roles: [] as any,
    loading: true,
  })
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    setRoleState({...roleState, roles: state.user.roles})
    setLoading(false)
  }, [state.user])

  const handleAddOrRemoveRoles = async (role_name: string) => {
    setLoading(true)
    setState({...state, infoSucess: false})
    const params = {
      data: {
        name: role_name,
      },
    }
    try {
      const response = await addOrRemoveRoles.addOrRemove(params)
      setState({...state, user: response.data, infoSucess: true})
    } catch (error) {
      console.error(error)
      setState({
        ...state,
        infoSucess: false,
        messageError: 'Não foi possível alterar o nível',
      })
    } finally {
      setLoading(false)
    }
  }

  const mainClassButton = (role_name: string): string[] => {
    const roles = roleState.roles
    const roleActive = roles.some((role: RoleModel) => role.name === role_name)
    if (roleActive) return ['btn', 'button-plus', 'label']

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
          {loading ? (
            <SpinnerBT />
          ) : (
            <>
              <Button
                className={mainClassButton('admin').join(' ')}
                onClick={() => handleAddOrRemoveRoles('admin')}>
                <i className="feather icon-users" /> Admin
              </Button>
              <Button
                className={mainClassButton('visitor').join(' ')}
                onClick={() => handleAddOrRemoveRoles('visitor')}>
                <i className="feather icon-users" /> Visitante
              </Button>
              <Button
                className={mainClassButton('rh').join(' ')}
                onClick={() => handleAddOrRemoveRoles('rh')}>
                <i className="feather icon-users" /> Editor
              </Button>
              <Button
                className={mainClassButton('normal').join(' ')}
                onClick={() => handleAddOrRemoveRoles('normal')}>
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
