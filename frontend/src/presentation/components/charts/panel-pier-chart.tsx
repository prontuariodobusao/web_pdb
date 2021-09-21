import React from 'react'
import {Row, Col, Card, Spinner} from 'react-bootstrap'
import HiPierChart from './hi-pier-chart'
import {ChartModel} from '../../../domain/models/charts-model'

type Props = {
  report: ChartModel[]
  titleReport: string
}

const PanelPierChart: React.FC<Props> = ({report, titleReport}: Props) => {
  return (
    <Card>
      <Card.Header>
        <Card.Title as="h5">Indicador</Card.Title>
      </Card.Header>
      <Card.Body>
        <HiPierChart
          data={report}
          title={titleReport}
          format="{point.name}<br> Qtd: {point.y}"
        />
      </Card.Body>
    </Card>
  )
}

export default PanelPierChart
