import React from 'react'

type TypeProps = {
  items: any
}

const NavIcon: React.FC<TypeProps> = ({items}: TypeProps) => {
  let navIcons: any = false
  if (items.icon) {
    navIcons = (
      <span className="pcoded-micon">
        <i className={items.icon} />
      </span>
    )
  }

  return <>{navIcons}</>
}

export default NavIcon
