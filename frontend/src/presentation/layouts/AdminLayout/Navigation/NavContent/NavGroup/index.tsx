import React, {Attributes} from 'react'
import {ListGroup} from 'react-bootstrap'
import NavCollapse from '../NavCollapse'
import NavItem from '../NavItem'

interface TypeProps extends Attributes {
  layout: string
  group: any
}

const NavGroup: React.FC<TypeProps> = ({layout, group}: TypeProps) => {
  let navItems: any = ''

  if (group.children) {
    const groups = group.children
    navItems = Object.keys(groups).map((item: any) => {
      item = groups[item]
      switch (item.type) {
        case 'collapse':
          return <NavCollapse key={item.id} collapse={item} type="main" />
        case 'item':
          return <NavItem layout={layout} key={item.id} item={item} />
        default:
          return false
      }
    })
  }

  return (
    <>
      <ListGroup.Item
        as="li"
        bsPrefix=" "
        key={group.id}
        className="nav-item pcoded-menu-caption">
        <label>{group.title}</label>
      </ListGroup.Item>
      {navItems}
    </>
  )
}

export default NavGroup
