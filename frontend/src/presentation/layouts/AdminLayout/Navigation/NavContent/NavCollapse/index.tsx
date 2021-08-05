import React, {useContext, useEffect, Attributes} from 'react'
import {ListGroup} from 'react-bootstrap'
import {Link} from 'react-router-dom'

import NavItem from '../NavItem'
import LoopNavCollapse from './index'
import NavIcon from '../NavIcon'
import NavBadge from '../NavBadge'

import {ConfigContext} from '../../../../../contexts/ConfigContext'
import * as actionType from '../../../../../store/actions'

interface TypeProps extends Attributes {
  collapse: any
  type: string
}

const NavCollapse: React.FC<TypeProps> = ({collapse, type}: TypeProps) => {
  const configContext = useContext(ConfigContext)
  const {dispatch}: any = configContext

  const {isOpen, isTrigger} = configContext

  useEffect(() => {
    const currentIndex = document.location.pathname
      .toString()
      .split('/')
      .findIndex(id => id === collapse.id)
    if (currentIndex > -1) {
      dispatch({
        type: actionType.COLLAPSE_TOGGLE,
        menu: {id: collapse.id, type: type},
      })
    }
  }, [collapse, dispatch, type])

  let navItems: any = ''
  if (collapse.children) {
    const collapses = collapse.children
    navItems = Object.keys(collapses).map((item: any) => {
      item = collapses[item]
      switch (item.type) {
        case 'collapse':
          return <LoopNavCollapse key={item.id} collapse={item} type="sub" />
        case 'item':
          return <NavItem layout="vertical" key={item.id} item={item} />
        default:
          return false
      }
    })
  }

  let itemTitle = collapse.title
  if (collapse.icon) {
    itemTitle = <span className="pcoded-mtext">{collapse.title}</span>
  }

  let navLinkClass = ['nav-link']

  let navItemClass = ['nav-item', 'pcoded-hasmenu']
  const openIndex = isOpen.findIndex(id => id === collapse.id)
  if (openIndex > -1) {
    navItemClass = [...navItemClass, 'active']
    navLinkClass = [...navLinkClass, 'active']
  }

  const triggerIndex = isTrigger.findIndex(id => id === collapse.id)
  if (triggerIndex > -1) {
    navItemClass = [...navItemClass, 'pcoded-trigger']
  }

  const currentIndex = document.location.pathname
    .toString()
    .split('/')
    .findIndex(id => id === collapse.id)
  if (currentIndex > -1) {
    navItemClass = [...navItemClass, 'active']
    navLinkClass = [...navLinkClass, 'active']
  }

  const subContent = (
    <React.Fragment>
      <Link
        to="#"
        className={navLinkClass.join(' ')}
        onClick={() =>
          dispatch({
            type: actionType.COLLAPSE_TOGGLE,
            menu: {id: collapse.id, type: type},
          })
        }>
        <NavIcon items={collapse} />
        {itemTitle}
        <NavBadge items={collapse} />
      </Link>
      <ListGroup
        variant="flush"
        bsPrefix=" "
        as="ul"
        className="pcoded-submenu">
        {navItems}
      </ListGroup>
    </React.Fragment>
  )

  let mainContent: any = ''
  mainContent = (
    <ListGroup.Item as="li" bsPrefix=" " className={navItemClass.join(' ')}>
      {subContent}
    </ListGroup.Item>
  )

  return <>{mainContent}</>
}

export default NavCollapse