import React, {useState} from 'react'
import {Card, Row, Col, Button} from 'react-bootstrap'
import Breadcrumb from '../../layouts/AdminLayout/Breadcrumb'
import logoPdb from '../../assets/images/logo-pdb.png'
import {Authentication} from '../../../domain/usecases/auth/authentication'
import useScriptRef from '../../hooks/useScriptRef'

import * as Yup from 'yup'
import {useFormik} from 'formik'

type Props = {
  authentication: Authentication
}

const SignIn: React.FC<Props> = ({authentication}: Props) => {
  const scriptedRef = useScriptRef()

  const formik = useFormik({
    initialValues: {
      username: '',
      password: '',
      submit: null,
      isLoading: false,
    },
    validationSchema: Yup.object().shape({
      username: Yup.string().max(255).required('Matricula é obrigatória'),
      password: Yup.string().max(255).required('Senha é obrigatóra'),
    }),
    onSubmit: async (values, {setErrors, setStatus, setSubmitting}) => {
      try {
        const response = await authentication.auth({
          username: values.username,
          password: values.password,
        })
        if (scriptedRef.current) {
          setStatus({success: true})
          setSubmitting(false)
        }
        // await saveAccount(response.auth_token)
      } catch (error: any) {
        console.log(error)
        setStatus({success: false})
        setErrors({submit: error})
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
              <form noValidate onSubmit={formik.handleSubmit}>
                <div className="form-group mb-3">
                  <input
                    className="form-control"
                    placeholder="Matrícula"
                    name="username"
                    type="text"
                    onBlur={formik.handleBlur}
                    onChange={formik.handleChange}
                    value={formik.values.username}
                  />
                  {formik.touched.username && formik.errors.username && (
                    <small className="text-danger form-text">
                      {formik.errors.username}
                    </small>
                  )}
                </div>
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
                <Row>
                  <Col>
                    <Button
                      className="btn-block"
                      color="primary"
                      disabled={formik.isSubmitting}
                      size="lg"
                      type="submit"
                      variant="primary">
                      Entrar
                      <i className="feather icon-log-in" />
                    </Button>
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

export default SignIn
