import React, {ReactNode, useState} from 'react'
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
  titleReport: string
  showChart: boolean
  component: ReactNode
}

const ChartsByDatePage: React.FC<Props> = ({chartsReportByDates}: Props) => {
  const [loading, setLoading] = useState(false)
  const [chart, setChart] = useState<ReportModel>({} as ReportModel)
  const [state, setState] = useState<InitialState>({
    typeReport: '1',
    titleReport: 'Categorias',
    startDate: new Date(),
    endDate: new Date(),
    showChart: false,
    component: <HiPierChart data={chart.report} title="Categorias" />,
  })

  const loadChartByDates = async (): Promise<void> => {
    const response = await chartsReportByDates.post({
      data: {
        type_report: parseInt(state.typeReport),
        initial_date: dateFormatStr(state.startDate),
        end_date: dateFormatStr(state.endDate),
      },
    })
    setState({
      ...state,
      showChart: true,
      component: (
        <HiPierChart data={response.report} title={state.titleReport} />
      ),
    })
  }

  const loadChart = async (): Promise<void> => {
    setLoading(true)
    setState({...state, showChart: false})
    try {
      loadChartByDates()
    } catch (error) {
      console.error(error)
    } finally {
      setLoading(false)
    }
  }

  const handleTypeChart = (e: React.ChangeEvent<any>) => {
    switch (e.target.value) {
      case '1':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Categorias',
        })
        break
      case '2':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Problemas',
        })
        break
      case '3':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Status',
        })
        break
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
              <Form.Row>
                <Form.Group as={Col} md="3">
                  <Form.Label>Informe o tipo de indicador</Form.Label>
                  <Form.Control
                    as="select"
                    name="occupation_id"
                    value={state.typeReport}
                    onChange={event => handleTypeChart(event)}>
                    <option value="1">Categorias</option>
                    <option value="2">Problemas</option>
                    <option value="3">Status</option>
                  </Form.Control>
                </Form.Group>
              </Form.Row>
              <Form.Row>
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
              {state.showChart && state.component}
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  )
}

export default ChartsByDatePage
