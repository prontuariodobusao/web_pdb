import React, {ReactNode, useState} from 'react'
import {Row, Col, Card, Form, Spinner} from 'react-bootstrap'
import {
  InputDatePicker,
  SubmitButton,
  HiPierChart,
  HiBarChart,
} from '../../../components'
import {ChartsReportByDates} from '../../../../domain/usecases/charts/charts-report-by-dates'
import {ChartsReportMecanicByDates} from '../../../../domain/usecases/charts/charts-report-mecanic-by-dates'
import {ChartsReportEmployeeProblemsByDates} from '../../../../domain/usecases/charts/charts-report_employee_problems_by_dates'
import {ListEmployee} from '../../../../domain/usecases/employees/list-employee'
import {ReportModel} from '../../../../domain/models/charts-model'
import {dateFormatStr} from '../../../../services'

type Props = {
  chartsReportByDates: ChartsReportByDates
  chartsReportMecanicByDates: ChartsReportMecanicByDates
  chartsReportEmployeeProblemsByDates: ChartsReportEmployeeProblemsByDates
  listEmployee: ListEmployee
}

type InitialState = {
  startDate: Date
  endDate: Date
  typeReport: string
  titleReport: string
  showChart: boolean
  isChartMecanic: boolean
  isChartMecanicEmployeeProble: boolean
  component: ReactNode
}

const ChartsByDatePage: React.FC<Props> = ({
  chartsReportByDates,
  chartsReportMecanicByDates,
  chartsReportEmployeeProblemsByDates,
  listEmployee,
}: Props) => {
  const [loading, setLoading] = useState(false)
  const [chart, setChart] = useState<ReportModel>({} as ReportModel)
  const [state, setState] = useState<InitialState>({
    typeReport: '1',
    titleReport: 'Categorias',
    startDate: new Date(),
    endDate: new Date(),
    showChart: false,
    isChartMecanic: false,
    isChartMecanicEmployeeProble: false,
    component: <HiPierChart data={chart.report} title="Categorias" />,
  })

  const loadListEmployee = async (): Promise<void> => {
    try {
      const response = await listEmployee.list()
    } catch (error) {
      console.error(error)
    }
  }

  const loadPierChartByDates = async (): Promise<void> => {
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
      component:
        state.typeReport === '2' ? (
          <HiBarChart data={response.report} title={state.titleReport} />
        ) : (
          <HiPierChart data={response.report} title={state.titleReport} />
        ),
    })
  }

  const loadBarChartMecanics = async (): Promise<void> => {
    const response = await chartsReportMecanicByDates.post({
      data: {
        initial_date: dateFormatStr(state.startDate),
        end_date: dateFormatStr(state.endDate),
      },
    })
    setState({
      ...state,
      showChart: true,
      component: (
        <>
          <HiBarChart
            data={response.orders_finish}
            title="Quantidade de OS atendida (FINALIZADAS) por mecânico"
          />
          <HiBarChart
            data={response.orders_maintenance}
            title="Quantidade de OS em atendimento (em MANUTENÇÃO) por mecânico"
          />
        </>
      ),
    })
  }

  const loadChart = async (): Promise<void> => {
    setLoading(true)
    setState({...state, showChart: false})
    try {
      if (
        state.typeReport === '1' ||
        state.typeReport === '2' ||
        state.typeReport === '3'
      ) {
        await loadPierChartByDates()
      } else if (state.typeReport === '4') {
        await loadBarChartMecanics()
      }
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
          isChartMecanic: false,
          isChartMecanicEmployeeProble: false,
        })
        break
      case '2':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Problemas',
          isChartMecanic: false,
          isChartMecanicEmployeeProble: false,
        })
        break
      case '3':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Status',
          isChartMecanic: false,
          isChartMecanicEmployeeProble: false,
        })
        break
      case '4':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Quantidade de OS atendida por mecânico',
          isChartMecanic: false,
          isChartMecanicEmployeeProble: false,
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
                    <option value="4">OS por mecânico</option>
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
