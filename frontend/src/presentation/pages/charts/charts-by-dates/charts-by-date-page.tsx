import React, {useState} from 'react'
import {Row, Col, Card, Form, Spinner} from 'react-bootstrap'
import {InputDatePicker, SubmitButton, HiPierChart} from '../../../components'
import {ChartsReportByDates} from '../../../../domain/usecases/charts/charts-report-by-dates'
import {ReportModel} from '../../../../domain/models/charts-model'
import {dateFormatStr} from '../../../../services'

type Props = {
  chartsReportByDates: ChartsReportByDates
}

type InitialState = {
  startDate: Date
  endDate: Date
  typeReport: string
  showChart: boolean
}

const ChartsByDatePage: React.FC<Props> = ({chartsReportByDates}: Props) => {
  const [loading, setLoading] = useState(false)
  const [chart, setChart] = useState<ReportModel>({} as ReportModel)
  const [state, setState] = useState<InitialState>({
    typeReport: '1',
    startDate: new Date(),
    endDate: new Date(),
    showChart: false,
  })

  const loadChart = async (): Promise<void> => {
    setLoading(true)
    setState({...state, showChart: false})
    try {
      const response = await chartsReportByDates.post({
        data: {
          type_report: parseInt(state.typeReport),
          initial_date: dateFormatStr(state.startDate),
          end_date: dateFormatStr(state.endDate),
        },
      })
      setChart(response)
      setState({...state, showChart: true})
    } catch (error) {
      console.error(error)
    } finally {
      setLoading(false)
    }
  }

  return (
    <>
      <Row>
        <Col md={12}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">
                Informe o tipo de indicador e as datas
              </Card.Title>
            </Card.Header>
            <Card.Body>
              <Form>
                <Form.Row>
                  <Form.Group as={Col} md="3">
                    <Form.Label>Informe o tipo de indicador</Form.Label>
                    <Form.Control
                      as="select"
                      name="occupation_id"
                      value={state.typeReport}
                      onChange={event =>
                        setState({...state, typeReport: event.target.value})
                      }>
                      <option value="1">Categorias</option>
                      <option value="2">Problemas</option>
                      <option value="3">Status</option>
                    </Form.Control>
                  </Form.Group>
                  <Form.Group as={Col} md="3">
                    <Form.Label>Data inicial</Form.Label>
                    <InputDatePicker
                      selected={state.startDate}
                      onChanche={(date: Date) =>
                        setState({...state, startDate: date})
                      }
                    />
                  </Form.Group>
                  <Form.Group as={Col} md="3">
                    <Form.Label>Data final</Form.Label>
                    <InputDatePicker
                      selected={state.endDate}
                      onChanche={(date: Date) =>
                        setState({...state, endDate: date})
                      }
                    />
                  </Form.Group>
                </Form.Row>
                <SubmitButton
                  loading={loading}
                  disabled={loading}
                  onClick={loadChart}>
                  Gerar Indicador <i className="feather icon-bar-chart-2" />
                </SubmitButton>
              </Form>
            </Card.Body>
          </Card>
        </Col>
      </Row>
      <Row>
        <Col md={12}>
          <Card>
            <Card.Header>
              <Card.Title as="h5">Indicador</Card.Title>
            </Card.Header>
            <Card.Body>
              {loading && <Spinner animation="grow" variant="info" />}
              {state.showChart && <HiPierChart data={chart.report} />}
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default ChartsByDatePage
