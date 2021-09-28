import React, {ReactNode, useState} from 'react'
import {Row, Col, Card, Form, Spinner} from 'react-bootstrap'
import {
  InputDatePicker,
  SubmitButton,
  HiPierChart,
  HiBarChart,
  SelectField,
} from '../../../components'
import {ChartsReportByDates} from '../../../../domain/usecases/charts/charts-report-by-dates'
import {ChartsReportMecanicByDates} from '../../../../domain/usecases/charts/charts-report-mecanic-by-dates'
import {ChartsReportEmployeeProblemsByDates} from '../../../../domain/usecases/charts/charts-report_employee_problems_by_dates'
import {ListEmployee} from '../../../../domain/usecases/employees/list-employee'
import {dateFormatStr} from '../../../../services'
import {ListEmployeeData} from '../../../../domain/models/employee-models'

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
  employeeId: number
  employeeType: string
  titleReport: string
  showChart: boolean
  isChartMecanic: boolean
  isChartEmployeeProblem: boolean
  component: ReactNode
}

const ChartsByDatePage: React.FC<Props> = ({
  chartsReportByDates,
  chartsReportMecanicByDates,
  chartsReportEmployeeProblemsByDates,
  listEmployee,
}: Props) => {
  const [loading, setLoading] = useState(false)
  const [listEmployeeSelect, setListEmployeeSelect] =
    useState<ListEmployeeData>([] as ListEmployeeData)
  const [state, setState] = useState<InitialState>({
    typeReport: '1',
    titleReport: 'Categorias',
    startDate: new Date(),
    endDate: new Date(),
    employeeId: 0,
    employeeType: '',
    showChart: false,
    isChartMecanic: false,
    isChartEmployeeProblem: false,
    component: null,
  })

  const loadListEmployee = async (occupation: string): Promise<void> => {
    try {
      const response = await listEmployee.list(occupation)
      setListEmployeeSelect(response)
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

  const loadBarChartEmployeeProblems = async (): Promise<void> => {
    const response = await chartsReportEmployeeProblemsByDates.post({
      data: {
        initial_date: dateFormatStr(state.startDate),
        end_date: dateFormatStr(state.endDate),
        employee_id: state.employeeId,
        employee_type: state.employeeType,
      },
    })
    setState({
      ...state,
      showChart: true,
      component: (
        <HiBarChart data={response.report} title={state.titleReport} />
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
      } else if (state.typeReport === '5' || state.typeReport === '6') {
        await loadBarChartEmployeeProblems()
      }
    } catch (error) {
      console.error(error)
    } finally {
      setLoading(false)
    }
  }

  const handleTypeChart = async (e: React.ChangeEvent<any>) => {
    switch (e.target.value) {
      case '1':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Categorias',
          isChartMecanic: false,
          isChartEmployeeProblem: false,
          employeeId: 0,
          employeeType: '',
        })
        break
      case '2':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Problemas',
          isChartMecanic: false,
          isChartEmployeeProblem: false,
        })
        break
      case '3':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Status',
          isChartMecanic: false,
          isChartEmployeeProblem: false,
          employeeId: 0,
          employeeType: '',
        })
        break
      case '4':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Quantidade de OS atendida por mecânico',
          isChartMecanic: false,
          isChartEmployeeProblem: false,
          employeeId: 0,
          employeeType: '',
        })
        break
      case '5':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Relação entre mecânico e problemas',
          isChartMecanic: false,
          isChartEmployeeProblem: true,
          employeeType: 'mecanic',
        })
        await loadListEmployee('mecanic')
        break
      case '6':
        setState({
          ...state,
          typeReport: String(e.target.value),
          showChart: false,
          titleReport: 'Relação entre motorista e problemas',
          isChartMecanic: false,
          isChartEmployeeProblem: true,
          employeeType: 'driver',
        })
        await loadListEmployee('driver')
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
                    <option value="4">Qtd de OS por mecâncico</option>
                    <option value="5">Mecânico X Problema</option>
                    <option value="6">Motorista X Problema</option>
                  </Form.Control>
                </Form.Group>
                {state.isChartEmployeeProblem && (
                  <SelectField
                    isSelected={String(state.employeeId)}
                    label="Selecione o funcionário"
                    options={listEmployeeSelect}
                    onChangeValue={e =>
                      setState({
                        ...state,
                        employeeId: Number(e.target.value),
                      })
                    }
                  />
                )}
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
