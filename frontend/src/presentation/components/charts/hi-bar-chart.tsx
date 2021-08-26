import React from 'react'
import Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'
import {ChartModel} from '../../../domain/models/charts-model'

// The wrapper exports only a default component class that at the same time is a
// namespace for the related Props interface (HighchartsReact.Props). All other
// interfaces like Options come from the Highcharts module itself.

type Props = {
  data: ChartModel[]
  props?: HighchartsReact.Props
}

const HiBarChart: React.FC<Props> = ({data, props}: Props) => {
  const options = {
    credits: {
      enabled: false,
    },
    chart: {
      type: 'column',
    },
    colors: ['#1de9b6'],
    title: {
      text: 'Problemas',
    },
    accessibility: {
      announceNewData: {
        enabled: true,
      },
    },
    xAxis: {
      type: 'category',
    },
    yAxis: {
      title: {
        text: 'Total percent market share',
      },
    },
    legend: {
      enabled: false,
    },
    plotOptions: {
      series: {
        borderWidth: 0,
        dataLabels: {
          enabled: true,
          format: '{point.y:.1f}%',
        },
      },
    },

    tooltip: {
      headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
      pointFormat:
        '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>',
    },

    series: [
      {
        name: 'Browsers',
        colorByPoint: true,
        data: data,
      },
    ],
  }

  return (
    <div>
      <HighchartsReact highcharts={Highcharts} options={options} {...props} />
    </div>
  )
}

export default HiBarChart
