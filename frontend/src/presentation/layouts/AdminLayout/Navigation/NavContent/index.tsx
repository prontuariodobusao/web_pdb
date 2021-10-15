import React, {useContext} from 'react'
import {ListGroup} from 'react-bootstrap'
import PerfectScrollbar from 'react-perfect-scrollbar'
import {AuthContext} from '../../../../contexts'

import NavGroup from './NavGroup'

type TypeProps = {
  navigation: any
}

const NavContent: React.FC<TypeProps> = ({navigation}: TypeProps) => {
  const {getCurrentAccount} = useContext(AuthContext)
  // const accessLevel = navigation.filter((item: any) => {
  //   console.log(item)
  //   item.access.includes('manager')
  // })

  const navItems = navigation.map((item: any) => {
    if (item.access.includes(getCurrentAccount().role)) {
      const filteredItems = item.children.filter((item: any) =>
        item.access.includes(getCurrentAccount().role),
      )
      const filteredItem = {...item, children: filteredItems}
      return (
        <NavGroup
          layout="vertical"
          key={'nav-group-' + filteredItem.id}
          group={filteredItem}
        />
      )
    } else {
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
