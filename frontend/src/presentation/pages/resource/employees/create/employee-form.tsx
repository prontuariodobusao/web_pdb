import React from 'react'
import {Form, Row, Col, Alert} from 'react-bootstrap'
import {SubmitButton} from '../../../../components'
import * as Yup from 'yup'
import {useFormik} from 'formik'
import {CreateEmployee} from '../../../../../domain/usecases/employees'
import {useHistory} from 'react-router-dom'

type Props = {
  remoteCreateEmployee: CreateEmployee
}

const schema = Yup.object().shape({
  name: Yup.string().required('Nome é obrigatório'),
  identity: Yup.string().required('Matrícula é obrigatória'),
  occupation_id: Yup.string().required('Cargo é obrigatório'),
})

const EmployeeForm: React.FC<Props> = ({remoteCreateEmployee}: Props) => {
  const history = useHistory()
  const formik = useFormik({
    validationSchema: schema,
    initialValues: {
      name: '',
      identity: '',
      occupation_id: '',
      is_user: false,
      submit: null,
      isLoading: false,
    },
    onSubmit: async (values, {setErrors, setStatus, setSubmitting}) => {
      try {
        const {name, identity, is_user} = values
        const occupation_id = parseInt(values.occupation_id)
        await remoteCreateEmployee.create({
          data: {
            name,
            identity,
            occupation_id,
            is_user,
          },
        })
        history.replace('/funcionarios')
      } catch (error: any) {
        setStatus({success: false})
        setErrors({submit: error.message})
        setSubmitting(false)
      }
    },
  })

  return (
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
        <Form.Group>
          <Form.Check
            name="is_user"
            label="Cadastrar usuário para este funcionário?"
            onChange={formik.handleChange}
          />
        </Form.Group>
        <SubmitButton
          type="submit"
          loading={formik.isSubmitting}
          disabled={formik.isSubmitting}>
          Cadastrar <i className="feather icon-plus-circle" />
        </SubmitButton>
      </Form>
    </>
  )
}

export default EmployeeForm
