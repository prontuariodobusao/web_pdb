import React, {useState} from 'react'
import {useAsyncDebounce} from 'react-table'

const GlobalFilter: React.FC<any> = ({globalFilter, setGlobalFilter}: any) => {
  const [value, setValue] = React.useState(globalFilter)
  const onChange = useAsyncDebounce(value => {
    setGlobalFilter(value || undefined)
  }, 200)
  return (
    <span>
      Search:{' '}
      <input
        value={value || ''}
        onChange={e => {
          setValue(e.target.value)
          onChange(e.target.value)
        }}
        placeholder={'Pesquisar'}
        style={{
          fontSize: '1.1rem',
          border: '0',
        }}
      />
    </span>
  )
}

export default GlobalFilter
