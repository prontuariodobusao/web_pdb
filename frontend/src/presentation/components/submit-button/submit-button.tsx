import React from 'react'
import {ButtonContainer, ButtonText} from './styles'
import {ButtonProps, Spinner} from 'react-bootstrap'

interface ButtonProp extends ButtonProps {
  children: string
  loading?: boolean
}

const SubmitButton: React.FC<ButtonProp> = ({
  loading,
  children,
  ...rest
}: ButtonProp) => {
  return (
    <ButtonContainer {...rest}>
      {loading ? (
        <Spinner animation="border" variant="light" size="sm" />
      ) : (
        <>
          <ButtonText>{children}</ButtonText>
          <i className="feather icon-log-in" />
        </>
      )}
    </ButtonContainer>
  )
}

export default SubmitButton
