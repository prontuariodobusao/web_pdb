import React, {useContext} from 'react'
import {Link} from 'react-router-dom'

import {ConfigContext} from '../../../../contexts/ConfigContext'
import * as actionType from '../../../../store/actions'

const NavLogo: React.FC = () => {
  const configContext = useContext(ConfigContext)
  const {collapseMenu} = configContext
  const {dispatch}: any = configContext

  let toggleClass = ['mobile-menu']
  if (collapseMenu) {
    toggleClass = [...toggleClass, 'on']
  }

  return (
    <>
      <div className="navbar-brand header-logo">
        <Link to="#" className="b-brand">
          <div className="b-bg">
            <i className="feather icon-trending-up" />
          </div>
          <span className="b-title">Datta Able</span>
        </Link>
        <Link
          to="#"
          className={toggleClass.join(' ')}
          id="mobile-collapse"
          onClick={() => dispatch({type: actionType.COLLAPSE_MENU})}>
          <span />
        </Link>
      </div>
    </>
  )
}

export default NavLogo
