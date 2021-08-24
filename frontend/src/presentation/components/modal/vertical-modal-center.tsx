import React, {ReactNode} from 'react'
import {Button, Modal} from 'react-bootstrap'

type ModalProps = {
  show: boolean
  onHide: (value: React.SetStateAction<boolean>) => void
  children: ReactNode
}

const VerticallyCenteredModal: React.FC<ModalProps> = ({
  show,
  onHide,
  children,
}: ModalProps) => {
  return (
    <Modal
      show={show}
      onHide={onHide}
      size="lg"
      aria-labelledby="contained-modal-title-vcenter"
      centered>
      <Modal.Header closeButton>
        <Modal.Title id="contained-modal-title-vcenter">
          Modal heading
        </Modal.Title>
      </Modal.Header>
      <Modal.Body>{children}</Modal.Body>
      <Modal.Footer>
        <Button>Close</Button>
      </Modal.Footer>
    </Modal>
  )
}

export default VerticallyCenteredModal
