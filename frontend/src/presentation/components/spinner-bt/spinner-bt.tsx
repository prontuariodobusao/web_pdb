import React from 'react'
import {Spinner} from 'react-bootstrap'

const SpinnerBT: React.FC = () => {
  return (
    <div
      style={{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
      }}>
      <Spinner animation="border" variant="info" />
    </div>
  )
}

export default SpinnerBT
