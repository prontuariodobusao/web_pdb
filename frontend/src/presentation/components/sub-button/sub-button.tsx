import React, {ReactNode} from 'react'
import {ButtonProps, Spinner, Button} from 'react-bootstrap'

interface ButtonProp extends ButtonProps {
  children: ReactNode
  loading?: boolean
}

const SubButton: React.FC<ButtonProp> = ({
  loading,
  children,
  ...rest
}: ButtonProp) => {
  return (
    <Button {...rest}>
      {loading ? (
        <Spinner animation="border" variant="light" size="sm" />
      ) : (
        <>{children}</>
      )}
    </Button>
  )
}

export default SubButton
