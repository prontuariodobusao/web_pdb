import React from 'react'
import {Form, Col} from 'react-bootstrap'

type OptionList = {
  id: number
  name: string
}

type Props = {
  isSelected?: string
  options: OptionList[]
  onChangeValue: (e: React.ChangeEvent<any>) => void
  label: string
}

const SelectField: React.FC<Props> = ({
  isSelected,
  options,
  onChangeValue,
  label,
}: Props) => {
  return (
    <Form.Group as={Col} md="3">
      <Form.Label>{label}</Form.Label>
      <Form.Control
        as="select"
        name="employee_id"
        value={isSelected}
        onChange={e => onChangeValue(e)}>
        <option value="">--Selecione--</option>
        {options.map(option => (
          <option key={option.id} value={option.id}>
            {option.name}
          </option>
        ))}
      </Form.Control>
    </Form.Group>
  )
}

export default SelectField
