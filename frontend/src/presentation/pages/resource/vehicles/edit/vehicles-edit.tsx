import React, {useState, useContext, useEffect} from 'react'
import {Form, Row, Col, Alert} from 'react-bootstrap'
import {SubmitButton} from '../../../../components'
import * as Yup from 'yup'
import {useFormik} from 'formik'
import {
  EditVehicles,
  GetVehicles,
} from '../../../../../domain/usecases/vehicles'
import {VehicleModel} from '../../../../../domain/models/vehicle-model'
import {DataTableContext} from '../../../../contexts'
import {
  CreateAddVehiclesUser,
  CreateAddOrRemoveRolesPage,
} from '../../../../../main/factories'

type Props = {
  remoteEditVehicles: EditVehicles
  remoteGetVehicles: GetVehicles
}

type StateComponent = {
  infoSucess: boolean
  vehicles: VehicleModel
}

const schema = Yup.object().shape({
  car_name: Yup.string().required('Nome é obrigatório'),
  //   identity: Yup.string().required('Matrícula é obrigatória'),
  //   occupation_id: Yup.string().required('Cargo é obrigatório'),
})

const VehiclesEdit: React.FC<Props> = ({
  remoteEditVehicles,
  remoteGetVehicles,
}: Props) => {
  const {reloadTable} = useContext(DataTableContext)
  const [state, setState] = useState<StateComponent>({
    infoSucess: false,
    vehicles: {
      id: 0,
      car_number: '',
    },
  })

  const loadVehiclesToEdit = async (): Promise<void> => {
    remoteGetVehicles
      .get()
      .then(vehicles => setState({...state, vehicles: vehicles.data}))
      .catch(() => console.log('Não foi possível realizar a ação!'))
  }

  useEffect(() => {
    loadVehiclesToEdit()
  }, [])

  const formik = useFormik({
    validationSchema: schema,
    enableReinitialize: true,
    initialValues: {
      car_name: state.vehicles.car_number,
      //   identity: state.vehicles.identity,
      //   occupation_id: String(state.vehicles.occupation_id),
      submit: null,
    },
    onSubmit: async (values, {setErrors, setStatus, setSubmitting}) => {
      try {
        // const {name, identity} = values
        // const occupation_id = parseInt(values.occupation_id)
        const {car_name} = values
        const response = await remoteEditVehicles.edit({
          data: {
            car_name,
            // identity,
            // occupation_id,
          },
        })
        setState({
          infoSucess: true,
          vehicles: response.data,
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
              <Alert variant="success">Veículo editado com sucesso!</Alert>
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
                Matrícula
              </Form.Label>
              <Col sm="10">
                <Form.Control
                  plaintext
                  readOnly
                  defaultValue={state.vehicles.}
                />
              </Col>
            </Form.Group> */}
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
                  placeholder="Número do carro"
                  name="identity"
                  value={formik.values.car_name}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.car_name}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.car_name}
                </Form.Control.Feedback>
              </Form.Group>
              <Form.Group as={Col} md="6" controlId="validationCustom02">
                <Form.Label>Nome</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Nome"
                  name="name"
                  value={formik.values.car_name}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.car_name}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.car_name}
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
                    <option value="3">Mecânico</option>
                    <option value="4">RH</option>
                    <option value="5">Visitante</option>
                  </Form.Control>
                  <Form.Control.Feedback type="invalid">
                    {formik.errors.occupation_id}
                  </Form.Control.Feedback>
                </Form.Group>
              </Col>
            </Row> */}
            <SubmitButton
              type="submit"
              loading={formik.isSubmitting}
              disabled={formik.isSubmitting}>
              Editar <i className="feather icon-edit" />
            </SubmitButton>
          </Form>
        </>
      )}
      {/* <hr /> */}
      {/* {state.vehicles.user?.id ? (
        <>
          <h5>Conta de Usuário</h5>
          <CreateUserResetPassword
            userIdParams={String(state.vehicles.user?.id)}
          />
          <hr />
          <h5>Níveis de usuários</h5>
          <CreateAddOrRemoveRolesPage user={state.vehicles.user} />
        </>
      ) : (
        <CreateAddVehiclesUser vehiclesId={String(state.vehicles.id)} />
      )} */}
    </>
  )
}

export default VehiclesEdit
