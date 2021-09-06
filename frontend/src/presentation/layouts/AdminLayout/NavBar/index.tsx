import React, {useContext} from 'react'
import {Link} from 'react-router-dom'

import NavLeft from './NavLeft'
import NavRight from './NavRight'

import {ConfigContext} from '../../../contexts/ConfigContext'
import * as actionType from '../../../store/actions'
import logoPdb from '../../../../assets/images/log_pdb_bar.png'

const NavBar: React.FC = () => {
  const configContext = useContext(ConfigContext)
  const collapseMenu: any = configContext.collapseMenu
  const {dispatch}: any = configContext

  const headerClass = [
    'navbar',
    'pcoded-header',
    'navbar-expand-lg',
    'navbar-default',
  ]

  let toggleClass = ['mobile-menu']
  if (collapseMenu) {
    toggleClass = [...toggleClass, 'on']
  }

  const navToggleHandler = () => {
    dispatch({type: actionType.COLLAPSE_MENU})
  }

  const collapseClass = ['collapse navbar-collapse']

  const navBar = (
    <>
      <div className="m-header">
        <Link
          to="#"
          className={toggleClass.join(' ')}
          id="mobile-collapse"
          onClick={navToggleHandler}>
          <span />
        </Link>
        <Link to="#" className="b-brand">
          <div className="b-bg">
            <i className="feather icon-trending-up" />
          </div>
        </Link>
        {/* <Link to='#' className={moreClass.join(' ')} onClick={() => setMoreToggle(!moreToggle)}>
                    <i className="feather icon-more-vertical"/>
                </Link> */}
      </div>
      <div className={collapseClass.join(' ')}>
        {/* <NavLeft /> */}
        <NavRight />
      </div>
    </>
  )

  return (
    <>
      <header className={headerClass.join(' ')}>{navBar}</header>
    </>
  )
}

export default NavBar
