import React, {useState, useContext} from 'react'
import {Card, Row, Col, Alert} from 'react-bootstrap'
import Breadcrumb from '../../layouts/AdminLayout/Breadcrumb'
import logoPdb from '../../assets/images/logo-pdb.png'
import {Confirmation} from '../../../domain/usecases/confirm/confirmation'
import {GetMessageError} from '../../../domain/errors'
import {ErrorsModel} from '../../../data/models'
import useScriptRef from '../../hooks/useScriptRef'
import {SubmitButton} from '../../components'
import {AuthContext} from '../../contexts'

import * as Yup from 'yup'
import {useFormik} from 'formik'

type Props = {
  confirm: Confirmation
}

const ConfirmationPage: React.FC<Props> = ({confirm}: Props) => {
  const scriptedRef = useScriptRef()
  const [loading, setLoading] = useState(false)
  const [messagesError, setMessagesError] = useState('')

  const {updateStateAccount} = useContext(AuthContext)

  const formik = useFormik({
    initialValues: {
      password: '',
      passwordConfirmation: '',
    },
    validationSchema: Yup.object().shape({
      password: Yup.string().max(255).required('Senha é obrigatóra'),
      passwordConfirmation: Yup.string()
        .max(255)
        .required('Nova Senha é obrigatóra'),
    }),
    onSubmit: async (values, {setStatus, setSubmitting}) => {
      setLoading(true)
      try {
        const response = await confirm.confirm({
          data: {
            password: values.password,
            password_confirmation: values.passwordConfirmation,
          },
        })
        await updateStateAccount(response.data)
        if (scriptedRef.current) {
          setStatus({success: true})
          setSubmitting(false)
        }
      } catch (error: any) {
        const errorObject = error as GetMessageError
        const errors: ErrorsModel[] = errorObject.getErrors() as ErrorsModel[]
        setMessagesError(errors.map(err => err.detail).join('; '))
        setLoading(false)
        setStatus({success: false})
        setSubmitting(false)
      }
    },
  })

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
              {messagesError && (
                <Row>
                  <Col sm={12}>
                    <Alert variant="danger">{messagesError}</Alert>
                  </Col>
                </Row>
              )}
              <form noValidate onSubmit={formik.handleSubmit}>
                <div className="form-group mb-4">
                  <input
                    className="form-control"
                    placeholder="Senha"
                    name="password"
                    type="password"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    value={formik.values.password}
                  />
                  {formik.touched.password && formik.errors.password && (
                    <small className="text-danger form-text">
                      {formik.errors.password}
                    </small>
                  )}
                </div>
                <div className="form-group mb-4">
                  <input
                    className="form-control"
                    placeholder="Confirmação da nova senha"
                    name="passwordConfirmation"
                    type="password"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    value={formik.values.passwordConfirmation}
                  />
                  {formik.touched.passwordConfirmation &&
                    formik.errors.passwordConfirmation && (
                      <small className="text-danger form-text">
                        {formik.errors.passwordConfirmation}
                      </small>
                    )}
                </div>
                <Row>
                  <Col>
                    <SubmitButton
                      className="btn-block"
                      color="primary"
                      disabled={formik.isSubmitting}
                      size="lg"
                      type="submit"
                      variant="primary"
                      loading={loading}>
                      Atualizar Senha
                    </SubmitButton>
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

export default ConfirmationPage
