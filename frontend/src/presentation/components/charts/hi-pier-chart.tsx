import React from 'react'
import * as Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'

// The wrapper exports only a default component class that at the same time is a
// namespace for the related Props interface (HighchartsReact.Props). All other
// interfaces like Options come from the Highcharts module itself.

const pieColors = (base: string) => {
  const colors = []
  let i
  for (i = 0; i < 10; i += 1) {
    colors.push(
      Highcharts.color(base)
        .brighten((i - 3) / 7)
        .get(),
    )
  }
  return colors
}

const options = {
  credits: {
    enabled: false,
  },
  chart: {
    plotBackgroundColor: null,
    plotBorderWidth: null,
    plotShadow: false,
    type: 'pie',
  },
  title: {
    text: 'Categorias',
  },
  tooltip: {
    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>',
  },
  accessibility: {
    point: {
      valueSuffix: '%',
    },
  },
  plotOptions: {
    pie: {
      allowPointSelect: true,
      cursor: 'pointer',
      colors: ['#3ebfea', '#1de9b6', '#f4c22b', '#ff8a65'],
      dataLabels: {
        enabled: true,
        format: '{point.name}<br>{point.percentage:.1f} %',
        distance: -40,
        filter: {
          property: 'percentage',
          operator: '>',
          value: 4,
        },
        style: {
          fontWeight: 'bold',
        },
      },
    },
  },
  series: [
    {
      name: 'Brands',
      colorByPoint: true,
      data: [
        {
          name: 'Motor',
          y: 61.41,
          sliced: true,
          selected: true,
        },
        {
          name: 'Carroceria',
          y: 11.84,
        },
        {
          name: 'Elétrica',
          y: 10.85,
        },
        {
          name: 'Suspensão',
          y: 4.67,
        },
      ],
    },
  ],
}

const HiPierChart: React.FC = (props: HighchartsReact.Props) => (
  <div>
    <HighchartsReact highcharts={Highcharts} options={options} {...props} />
  </div>
)

export default HiPierChart