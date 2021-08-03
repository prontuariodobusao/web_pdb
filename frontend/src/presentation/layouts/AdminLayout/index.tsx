import React, {useContext, useEffect, useRef} from 'react'

import Navigation from './Navigation'
import NavBar from './NavBar'
import Breadcrumb from './Breadcrumb'

import useWindowSize from '../../hooks/useWindowSize'
import useOutsideClick from '../../hooks/useOutsideClick'
import {ConfigContext} from '../../contexts/ConfigContext'
import * as actionType from '../../store/actions'

const AdminLayout: React.FC = ({children}: any) => {
  const windowSize = useWindowSize()
  const ref = useRef<any>(null)
  const configContext = useContext(ConfigContext)

  const collapseMenu = configContext.collapseMenu
  const {dispatch}: any = configContext

  useOutsideClick(ref, () => {
    if (collapseMenu) {
      dispatch({type: actionType.COLLAPSE_MENU})
    }
  })

  useEffect(() => {
    if (windowSize.width > 992 && windowSize.width <= 1024) {
      dispatch({type: actionType.COLLAPSE_MENU})
    }
  }, [dispatch, windowSize])

  const mobileOutClickHandler = () => {
    if (windowSize.width < 992 && collapseMenu) {
      dispatch({type: actionType.COLLAPSE_MENU})
    }
  }

  const mainClass = ['pcoded-wrapper']

  let common = (
    <React.Fragment>
      <Navigation />
    </React.Fragment>
  )

  let mainContainer = (
    <React.Fragment>
      <NavBar />
      <div className="pcoded-main-container">
        <div className={mainClass.join(' ')}>
          <div className="pcoded-content">
            <div className="pcoded-inner-content">
              <Breadcrumb />
              {children}
            </div>
          </div>
        </div>
      </div>
    </React.Fragment>
  )

  if (windowSize.width < 992) {
    let outSideClass = ['nav-outside']
    if (collapseMenu) {
      outSideClass = [...outSideClass, 'mob-backdrop']
    }

    common = (
      <div className={outSideClass.join(' ')} ref={ref}>
        {common}
      </div>
    )

    mainContainer = (
      <div className="pcoded-outside" onClick={() => mobileOutClickHandler}>
        {mainContainer}
      </div>
    )
  }

  return (
    <>
      {common}
      {mainContainer}
    </>
  )
}

export default AdminLayout
