import React from 'react'
import Progress from './Progress'

const Loader: React.FC = () => {
  return (
    <React.Fragment>
      <Progress isAnimating />
    </React.Fragment>
  )
}

export default Loader
