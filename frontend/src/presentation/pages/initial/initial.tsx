import React, {useContext} from 'react'
import {AuthContext} from '../../contexts'

const Initial: React.FC = () => {
  const {getCurrentAccount} = useContext(AuthContext)

  return (
    <div>
      <h2>
        Seja bem vindo(a){' '}
        <span style={{color: '#289ABB'}}>{getCurrentAccount().name}!</span>
      </h2>
      <h4>Utilize o menu lateral para navegar no prontuário do busão.</h4>
    </div>
  )
}

export default Initial
