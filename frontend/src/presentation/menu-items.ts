const menuItems = {
  items: [
    {
      id: 'navigation',
      title: 'Menu',
      type: 'group',
      icon: 'icon-navigation',
      children: [
        {
          id: 'dashboard',
          title: 'Dashboard',
          type: 'item',
          url: '/dashboard',
          icon: 'feather icon-home',
        },
        {
          id: 'charts',
          title: 'Charts',
          type: 'item',
          url: '/charts',
          icon: 'feather icon-pie-chart',
        },
      ],
    },
  ],
}

export default menuItems
