import React from 'react'
import {Table} from 'react-bootstrap'

type TableProps = {
  data: any[]
}

const VehiclesRevisionsTable: React.FC<TableProps> = ({data}: TableProps) => (
  <Table responsive>
    <thead>
      <tr>
        <th>Nº do Veiculo</th>
        <th>Km Atual</th>
        <th>Km para próxima revisão</th>
      </tr>
    </thead>
    <tbody>
      {data.map(vehicle => (
        <tr key={vehicle.id}>
          <td>{vehicle.number}</td>
          <td>{vehicle.current_km}</td>
          <td>{vehicle.next_change}</td>
        </tr>
      ))}
    </tbody>
  </Table>
)

export default VehiclesRevisionsTable
