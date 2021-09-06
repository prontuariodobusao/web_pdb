import React, {ReactNode} from 'react'
import {Modal} from 'react-bootstrap'

type ModalProps = {
  show: boolean
  onHide: (value: any) => void
  children: ReactNode
  title: string
}

const VerticallyCenteredModal: React.FC<ModalProps> = ({
  show,
  onHide,
  children,
  title,
}: ModalProps) => {
  return (
    <Modal
      show={show}
      onHide={onHide}
      size="lg"
      aria-labelledby="contained-modal-title-vcenter"
      centered>
      <Modal.Header closeButton>
        <Modal.Title id="contained-modal-title-vcenter">{title}</Modal.Title>
      </Modal.Header>
      <Modal.Body>{children}</Modal.Body>
    </Modal>
  )
}

export default VerticallyCenteredModal
