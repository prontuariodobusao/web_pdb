import React, {useState, useContext, useEffect} from 'react'
import {Form, Row, Col, Alert} from 'react-bootstrap'
import {SubmitButton} from '../../../../components'
import * as Yup from 'yup'
import {useFormik} from 'formik'
import {
  EditEmployee,
  GetEmployee,
} from '../../../../../domain/usecases/employees'
import {EmployeeModel} from '../../../../../domain/models/employee-models'
import {DataTableContext} from '../../../../contexts'
import {
  CreateUserResetPassword,
  CreateAddEmployeeUser,
} from '../../../../../main/factories'

type Props = {
  remoteEditEmployee: EditEmployee
  remoteGetEmployee: GetEmployee
}

type StateComponent = {
  infoSucess: boolean
  employee: EmployeeModel
}

const schema = Yup.object().shape({
  name: Yup.string().required('Nome é obrigatório'),
  identity: Yup.string().required('Matrícula é obrigatória'),
  occupation_id: Yup.string().required('Cargo é obrigatório'),
})

const EmployeeEdit: React.FC<Props> = ({
  remoteEditEmployee,
  remoteGetEmployee,
}: Props) => {
  const {reloadTable} = useContext(DataTableContext)
  const [state, setState] = useState<StateComponent>({
    infoSucess: false,
    employee: {
      id: 0,
      name: '',
      identity: '',
      occupation: '',
    },
  })

  const loadEmployeeToEdit = async (): Promise<void> => {
    remoteGetEmployee
      .get()
      .then(employee => setState({...state, employee: employee.data}))
      .catch(() => console.log('Não foi possível realizar a ação!'))
  }

  useEffect(() => {
    loadEmployeeToEdit()
  }, [])

  const formik = useFormik({
    validationSchema: schema,
    enableReinitialize: true,
    initialValues: {
      name: state.employee.name,
      identity: state.employee.identity,
      occupation_id: String(state.employee.occupation_id),
      submit: null,
    },
    onSubmit: async (values, {setErrors, setStatus, setSubmitting}) => {
      try {
        const {name, identity} = values
        const occupation_id = parseInt(values.occupation_id)
        const response = await remoteEditEmployee.edit({
          data: {
            name,
            identity,
            occupation_id,
          },
        })
        setState({
          infoSucess: true,
          employee: response.data,
        })
        reloadTable()
      } catch (error: any) {
        setStatus({success: false})
        setErrors({submit: error.message})
        setSubmitting(false)
      }
    },
  })

  return (
    <>
      {state.infoSucess ? (
        <>
          <Row>
            <Col sm={12}>
              <Alert variant="success">Funcionário Editado com sucesso!</Alert>
            </Col>
          </Row>
          <Form>
            <Form.Group as={Row}>
              <Form.Label column sm="2">
                Nome
              </Form.Label>
              <Col sm="10">
                <Form.Control
                  plaintext
                  readOnly
                  defaultValue={state.employee.name}
                />
              </Col>
            </Form.Group>
            <Form.Group as={Row}>
              <Form.Label column sm="2">
                Matrícula
              </Form.Label>
              <Col sm="10">
                <Form.Control
                  plaintext
                  readOnly
                  defaultValue={state.employee.identity}
                />
              </Col>
            </Form.Group>
          </Form>
        </>
      ) : (
        <>
          {formik.errors.submit && (
            <Row>
              <Col sm={12}>
                <Alert variant="danger">{formik.errors.submit}</Alert>
              </Col>
            </Row>
          )}
          <Form noValidate onSubmit={formik.handleSubmit}>
            <Form.Row>
              <Form.Group as={Col} md="6">
                <Form.Label>Matricula</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Matricula"
                  name="identity"
                  value={formik.values.identity}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.identity}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.identity}
                </Form.Control.Feedback>
              </Form.Group>
              <Form.Group as={Col} md="6" controlId="validationCustom02">
                <Form.Label>Nome</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Nome"
                  name="name"
                  value={formik.values.name}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.name}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.name}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>
            <Row>
              <Col md={6}>
                <Form.Group>
                  <Form.Label>Cargo</Form.Label>
                  <Form.Control
                    as="select"
                    name="occupation_id"
                    value={formik.values.occupation_id}
                    onChange={formik.handleChange}
                    isInvalid={!!formik.errors.occupation_id}>
                    <option value="">Selecione o Cargo</option>
                    <option value="1">Motorista</option>
                    <option value="2">Gerente</option>
                    <option value="3">Mecãnico</option>
                    <option value="4">RH</option>
                    <option value="5">Visitante</option>
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {formik.errors.occupation_id}
                  </Form.Control.Feedback>
                </Form.Group>
              </Col>
            </Row>
            <SubmitButton
              type="submit"
              loading={formik.isSubmitting}
              disabled={formik.isSubmitting}>
              Editar <i className="feather icon-edit" />
            </SubmitButton>
          </Form>
        </>
      )}
      <hr />
      {state.employee.user_id ? (
        <>
          <h5>Conta de Usuário</h5>
          <CreateUserResetPassword
            userIdParams={String(state.employee.user_id)}
          />
        </>
      ) : (
        <CreateAddEmployeeUser employeeId={String(state.employee.id)} />
      )}
    </>
  )
}

export default EmployeeEdit
