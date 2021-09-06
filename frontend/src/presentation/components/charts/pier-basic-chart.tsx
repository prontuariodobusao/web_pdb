import React from 'react'
import {
  PieChart,
  Pie,
  Cell,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts'

const PierBasicChart: React.FC = () => {
  const data = [
    {name: 'Barra Estabilizadora', value: 7},
    {name: 'Fumaçando', value: 5},
    {name: 'Perda de força', value: 3},
    {name: 'Controcity', value: 2},
    {name: 'Fumê', value: 2},
    {name: 'Feixo de molas', value: 1},
  ]
  const COLORS = ['#3ebfea', '#1de9b6', '#f4c22b', '#ff8a65']

  const RADIAN = Math.PI / 180
  const renderCustomizedLabel = ({
    cx,
    cy,
    midAngle,
    innerRadius,
    outerRadius,
    percent,
    index,
  }: any) => {
    const radius = innerRadius + (outerRadius - innerRadius) * 0.5
    const x = cx + radius * Math.cos(-midAngle * RADIAN)
    const y = cy + radius * Math.sin(-midAngle * RADIAN)

    return (
      <text
        x={x}
        y={y}
        fill="white"
        textAnchor={x > cx ? 'start' : 'end'}
        dominantBaseline="central">
        {`${(percent * 100).toFixed(0)}%`}
      </text>
    )
  }

  const customTooltip = ({active, payload}: any) => {
    if (active) {
      return (
        <div
          className="custom-tooltip"
          style={{
            backgroundColor: '#ffff',
            padding: '5px',
            border: '1px solid #cccc',
          }}>
          <label>{`${payload[0].name} : ${payload[0].value}`}</label>
        </div>
      )
    }

    return null
  }
  return (
    <ResponsiveContainer width={'100%'} height={300}>
      <PieChart width={500} height={300}>
        <Pie
          data={data}
          cx="50%"
          cy="50%"
          labelLine={false}
          label={renderCustomizedLabel}
          outerRadius={90}
          fill="#8884d8"
          dataKey="value">
          {data.map((entry, index) => (
            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
          ))}
        </Pie>
        <Tooltip content={customTooltip} />
        <Legend />
      </PieChart>
    </ResponsiveContainer>
  )
}

export default PierBasicChart
