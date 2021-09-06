import React from 'react'
import './spinner-styler.scss'

type Props = React.HTMLAttributes<HTMLElement>

const Spinner: React.FC<Props> = (props: Props) => {
  return (
    <div {...props} className="spinner">
      <div />
      <div />
      <div />
      <div />
    </div>
  )
}

export default Spinner
