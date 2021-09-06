import React from 'react'

type Props = {
  items: any
}

const NavBadge: React.FC<Props> = ({items}: Props) => {
  let navBadges: any = false
  if (items.badge) {
    const badgeClass = ['label', 'pcoded-badge', items.badge.type]

    navBadges = (
      <span className={badgeClass.join(' ')}>{items.badge.title}</span>
    )
  }

  return <>{navBadges}</>
}

export default NavBadge
