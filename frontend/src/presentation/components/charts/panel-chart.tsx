import React from 'react'
import {Card} from 'react-bootstrap'
import HiPierChart from './hi-pier-chart'
import {ChartModel} from '../../../domain/models/charts-model'

type Props = {
  report: ChartModel[]
  titleReport: string
  typeReport: string
}

const PanelChart: React.FC<Props> = ({
  report,
  titleReport,
  typeReport,
}: Props) => {
  return (
    <Card>
      <Card.Header>
        <Card.Title as="h5">Indicador</Card.Title>
      </Card.Header>
      <Card.Body>
        {typeReport === '1' && (
          <HiPierChart
            data={report}
            title={titleReport}
            format="{point.name}<br> Qtd: {point.y}"
          />
        )}
      </Card.Body>
    </Card>
  )
}

export default PanelChart
