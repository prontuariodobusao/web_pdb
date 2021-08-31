/* eslint-disable @typescript-eslint/no-var-requires */
import React from 'react'
import * as Highcharts from 'highcharts'
import HighchartsReact from 'highcharts-react-official'
import {ChartModel} from '../../../domain/models/charts-model'

// require('highcharts/modules/exporting')(Highcharts)
// require('highcharts/modules/export-data')(Highcharts)

// Highcharts.setOptions({
//   lang: {
//     months: [
//       'Janeiro',
//       'Fevereiro',
//       'Março',
//       'Abril',
//       'Maio',
//       'Junho',
//       'Julho',
//       'Agosto',
//       'Setembro',
//       'Outubro',
//       'Novembro',
//       'Dezembro',
//     ],
//     shortMonths: [
//       'Jan',
//       'Fev',
//       'Mar',
//       'Abr',
//       'Mai',
//       'Jun',
//       'Jul',
//       'Ago',
//       'Set',
//       'Out',
//       'Nov',
//       'Dez',
//     ],
//     weekdays: [
//       'Domingo',
//       'Segunda',
//       'Terça',
//       'Quarta',
//       'Quinta',
//       'Sexta',
//       'Sábado',
//     ],
//     downloadCSV: 'Exportar CSV',
//     downloadXLS: 'Exportar XLS',
//     viewFullscreen: 'Visualizar em tela cheia',
//     printChart: 'Imprimir gráfico',
//   },
// })

// The wrapper exports only a default component class that at the same time is a
// namespace for the related Props interface (HighchartsReact.Props). All other
// interfaces like Options come from the Highcharts module itself.

// const pieColors = (base: string) => {
//   const colors = []
//   let i
//   for (i = 0; i < 10; i += 1) {
//     colors.push(
//       Highcharts.color(base)
//         .brighten((i - 3) / 7)
//         .get(),
//     )
//   }
//   return colors
// }

type Props = {
  data: ChartModel[]
  props?: HighchartsReact.Props
}

const HiPierChart: React.FC<Props> = ({data, props}: Props) => {
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
      pointFormat: '{series.name}: <b>{point.y}</b>',
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
        name: 'Qtd',
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
export default HiPierChart
