import React, {useState, useContext} from 'react'
import {Form, Row, Col, Alert} from 'react-bootstrap'
import {SubmitButton} from '../../../../components'
import * as Yup from 'yup'
import {useFormik} from 'formik'
import {CreateVehicle} from '../../../../../domain/usecases/vehicles'
import {VehicleModel} from '../../../../../domain/models/vehicle-model'
import {DataTableContext} from '../../../../contexts'

type Props = {
  remoteCreateVehicles: CreateVehicle
}

type StateComponent = {
  infoSucess: boolean
  vehicles: VehicleModel
  // password: string
}

const schema = Yup.object().shape({
  name: Yup.string().required('Nome é obrigatório'),
  identity: Yup.string().required('Matrícula é obrigatória'),
  occupation_id: Yup.string().required('Cargo é obrigatório'),
})

const VehiclesForm: React.FC<Props> = ({remoteCreateVehicles}: Props) => {
  const {reloadTable} = useContext(DataTableContext)
  const [state, setState] = useState<StateComponent>({
    infoSucess: false,
    vehicles: {
      id: 0,
      car_number: '',
      // identity: '',
      // occupation: '',
    },
    // password: '',
  })
  const formik = useFormik({
    validationSchema: schema,
    initialValues: {
      car_number: '',
      km: 0,
      car_line_id: 0,
      oil_date: '',
      tire_date: '',
      revision_date: '',
      submit: null,
      // identity: '',
      // occupation_id: '',
      // is_user: false,
      // submit: null,
      // isLoading: false,
    },
    onSubmit: async (values, {setErrors, setStatus, setSubmitting}) => {
      try {
        // const {name, identity, is_user} = values
        // const occupation_id = parseInt(values.occupation_id)
        const {
          car_number,
          km,
          car_line_id,
          oil_date,
          revision_date,
          tire_date,
        } = values
        const response = await remoteCreateVehicles.create({
          data: {
            car_number,
            km,
            car_line_id,
            oil_date,
            revision_date,
            tire_date,
            // identity,
            // occupation_id,
            // is_user,
          },
        })
        setState({
          infoSucess: true,
          vehicles: response.data,
          // password: response.password,
        })
        reloadTable()
      } catch (error: any) {
        setStatus({success: false})
        // setErrors({submit: error.message})
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
              <Alert variant="success">
                Funcionário cadastrado com sucesso!
              </Alert>
            </Col>
          </Row>
          <Form>
            <Form.Group as={Row}>
              <Form.Label column sm="2">
                Número do carro
              </Form.Label>
              <Col sm="10">
                <Form.Control
                  plaintext
                  readOnly
                  defaultValue={state.vehicles.car_number}
                />
              </Col>
            </Form.Group>
            {/* <Form.Group as={Row}>
              <Form.Label column sm="2">
                Quilometragem
              </Form.Label>
              <Col sm="10">
                <Form.Control
                  plaintext
                  readOnly
                  defaultValue={state.vehicles.km}
                />
              </Col>
            </Form.Group> */}
            {/* {formik.values.is_user && (
              <Form.Group as={Row}>
                <Form.Label column sm="2">
                  Senha de primeiro acesso
                </Form.Label>
                <Col sm="10">
                  <Form.Control
                    plaintext
                    readOnly
                    defaultValue={state.password}
                  />
                </Col>
              </Form.Group>
            )} */}
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
                  value={formik.values.car_line_id}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.car_line_id}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.car_line_id}
                </Form.Control.Feedback>
              </Form.Group>
              <Form.Group as={Col} md="6" controlId="validationCustom02">
                <Form.Label>Nome</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Nome"
                  name="name"
                  value={formik.values.car_number}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.car_number}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.car_number}
                </Form.Control.Feedback>
              </Form.Group>
            </Form.Row>
            {/* <Row>
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
                onChange={formik.handleChange}
                label="Cadastrar usuário para este funcionário?"
              />
            </Form.Group> */}
            <SubmitButton
              type="submit"
              loading={formik.isSubmitting}
              disabled={formik.isSubmitting}>
              Cadastrar <i className="feather icon-plus-circle" />
            </SubmitButton>
          </Form>
        </>
      )}
    </>
  )
}

export default VehiclesForm
