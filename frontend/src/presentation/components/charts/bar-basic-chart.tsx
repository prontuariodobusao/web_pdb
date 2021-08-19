import React from 'react'
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
} from 'recharts'

const BarBasicChart: React.FC = () => {
  const data = [
    {
      name: 'Motor',
      qtd: 7,
    },
    {
      name: 'Carroceria',
      qtd: 4,
    },
    {
      name: 'Elétrica',
      qtd: 6,
    },
    {
      name: 'Suspensão',
      qtd: 3,
    },
  ]
  return (
    <ResponsiveContainer width={'99%'} height={300}>
      <BarChart
        data={data}
        margin={{
          top: 5,
          right: 30,
          left: 1,
          bottom: 40,
        }}>
        <XAxis dataKey="name" angle={-60} height={50} tickSize={30} />
        <YAxis />
        <Tooltip />
        <Bar dataKey="qtd" fill="#1de9b6" />
      </BarChart>
    </ResponsiveContainer>
  )
}

export default BarBasicChart
