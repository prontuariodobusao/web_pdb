import React, {useState, useContext, useEffect} from 'react'
import {Form, Row, Col, Alert} from 'react-bootstrap'
import {SubmitButton} from '../../../../components'
import * as Yup from 'yup'
import {useFormik} from 'formik'
import {
  UpdateVehicle,
  GetVehicle,
} from '../../../../../domain/usecases/vehicles'
import {VehicleModel} from '../../../../../domain/models/vehicle-model'
import {DataTableContext} from '../../../../contexts'
import InputMask from 'react-input-mask'

// import {
//   CreateAddVehiclesUser,
//   CreateAddOrRemoveRolesPage,
// } from '../../../../../main/factories'

type Props = {
  remoteEditVehicles: UpdateVehicle
  remoteGetVehicles: GetVehicle
}

type StateComponent = {
  infoSucess: boolean
  vehicles: VehicleModel
}

const schema = Yup.object().shape({
  car_number: Yup.string().required('Nome é obrigatório'),
  km: Yup.number().required('Nome é obrigatório'),
  oil_date: Yup.string().required('Nome é obrigatório'),
  revision_date: Yup.string().required('Nome é obrigatório'),
  tire_date: Yup.string().required('Nome é obrigatório'),
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
      km: 0,
      car_line_id: 5,
      oil_date: '',
      tire_date: '',
      revision_date: '',
      // submit: null,
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
      car_number: state.vehicles.car_number,
      km: state.vehicles.km,
      car_line_id: state.vehicles.car_line_id,
      oil_date: state.vehicles.oil_date,
      revision_date: state.vehicles.revision_date,
      tire_date: state.vehicles.tire_date,
      //   identity: state.vehicles.identity,
      //   occupation_id: String(state.vehicles.occupation_id),
      submit: null,
    },
    onSubmit: async (values, {setErrors, setStatus, setSubmitting}) => {
      try {
        // const {name, identity} = values
        // const occupation_id = parseInt(values.occupation_id)
        const {
          car_number,
          km,
          car_line_id,
          oil_date,
          revision_date,
          tire_date,
        } = values
        const response = await remoteEditVehicles.update({
          data: {
            car_number,
            km,
            car_line_id,
            oil_date,
            revision_date,
            tire_date,
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
                <Form.Label>Número do carro</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Número do carro"
                  name="car_number"
                  value={formik.values.car_number}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.car_number}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.car_number}
                </Form.Control.Feedback>
              </Form.Group>
              <Form.Group as={Col} md="6" controlId="validationCustom02">
                <Form.Label>Km (Quilometragem)</Form.Label>
                <Form.Control
                  type="text"
                  placeholder="Km (Quilometragem)"
                  name="km"
                  value={formik.values.km}
                  onChange={formik.handleChange}
                  isInvalid={!!formik.errors.km}
                />

                <Form.Control.Feedback type="invalid">
                  {formik.errors.km}
                </Form.Control.Feedback>
              </Form.Group>
              <Form.Group as={Col} md="6" controlId="validationCustom03">
                <Form.Label>Data da troca de óleo</Form.Label>
                <InputMask
                  mask="99/99/9999"
                  value={formik.values.oil_date}
                  onChange={formik.handleChange}>
                  <Form.Control
                    type="text"
                    placeholder="Data da troca de óleo"
                    name="oil_date"
                    isInvalid={!!formik.errors.oil_date}
                  />
                </InputMask>
                <Form.Control.Feedback type="invalid">
                  {formik.errors.oil_date}
                </Form.Control.Feedback>
              </Form.Group>
              <Form.Group as={Col} md="6" controlId="validationCustom04">
                <Form.Label>Data da revisão</Form.Label>
                <InputMask
                  mask="99/99/9999"
                  value={formik.values.revision_date}
                  onChange={formik.handleChange}>
                  <Form.Control
                    type="text"
                    placeholder="Data da revisão"
                    name="revision_date"
                    isInvalid={!!formik.errors.revision_date}
                  />
                </InputMask>
                <Form.Control.Feedback type="invalid">
                  {formik.errors.revision_date}
                </Form.Control.Feedback>
              </Form.Group>
              <Form.Group as={Col} md="6" controlId="validationCustom05">
                <Form.Label>Data da troca de pneu</Form.Label>
                <InputMask
                  mask="99/99/9999"
                  value={formik.values.tire_date}
                  onChange={formik.handleChange}>
                  <Form.Control
                    type="text"
                    placeholder="Data da troca de pneu"
                    name="tire_date"
                    isInvalid={!!formik.errors.tire_date}
                  />
                </InputMask>
                <Form.Control.Feedback type="invalid">
                  {formik.errors.tire_date}
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
