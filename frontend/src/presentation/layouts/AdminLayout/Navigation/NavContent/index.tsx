import React from 'react'
import {ListGroup} from 'react-bootstrap'
import PerfectScrollbar from 'react-perfect-scrollbar'

import NavGroup from './NavGroup'

type TypeProps = {
  navigation: any
}

const NavContent: React.FC<TypeProps> = ({navigation}: TypeProps) => {
  const navItems = navigation.map((item: any) => {
    switch (item.type) {
      case 'group':
        return (
          <NavGroup
            layout="vertical"
            key={'nav-group-' + item.id}
            group={item}
          />
        )
      default:
        return false
    }
  })

  let mainContent: any = ''
  mainContent = (
    <div className="navbar-content datta-scroll">
      <PerfectScrollbar>
        <ListGroup
          variant="flush"
          as="ul"
          bsPrefix=" "
          className="nav pcoded-inner-navbar"
          id="nav-ps-next">
          {navItems}
        </ListGroup>
      </PerfectScrollbar>
    </div>
  )

  return <>{mainContent}</>
}

export default NavContent
