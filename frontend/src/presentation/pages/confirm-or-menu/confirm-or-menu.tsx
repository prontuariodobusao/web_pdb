import React, {useContext} from 'react'
import {AuthContext} from '../../../presentation/contexts'
import {CreateConfirmPage} from '../../../main/factories'
import {Redirect} from 'react-router-dom'

const ConfirmOrMenu: React.FC = () => {
  const {user} = useContext(AuthContext)

  return user.confirmation ? (
    <Redirect to="/dashboard" />
  ) : (
    <CreateConfirmPage userIdParams={user.id} />
  )
}

export default ConfirmOrMenu
