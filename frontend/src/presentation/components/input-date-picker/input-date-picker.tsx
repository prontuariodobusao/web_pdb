import React, {forwardRef} from 'react'
import {Form} from 'react-bootstrap'
import DatePicker, {registerLocale} from 'react-datepicker'

import 'react-datepicker/dist/react-datepicker.css'

import ptBR from 'date-fns/locale/pt-BR'
registerLocale('pt-BR', ptBR)

type Props = {
  onChanche: (date: Date) => void
  selected?: Date | null | undefined
}

const InputDatePicker: React.FC<Props> = ({selected, onChanche}: Props) => {
  // eslint-disable-next-line react/display-name
  const ExampleCustomInput = forwardRef(
    ({value, onClick}: any, ref: React.Ref<HTMLInputElement>) => (
      <Form.Control
        readOnly
        type="text"
        value={value}
        onClick={onClick}
        ref={ref}
      />
    ),
  )

  return (
    <DatePicker
      selected={selected}
      onChange={onChanche}
      locale="pt-BR"
      dateFormat="dd/MM/yyyy"
      customInput={<ExampleCustomInput />}
    />
  )
}

export default InputDatePicker
