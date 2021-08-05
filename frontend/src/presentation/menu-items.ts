const menuItems = {
  items: [
    {
      id: 'navigation',
      title: 'Navigation',
      type: 'group',
      icon: 'icon-navigation',
      children: [
        {
          id: 'dashboard',
          title: 'Dashboard',
          type: 'item',
          url: '/app/dashboard/default',
          icon: 'feather icon-home',
        },
        {
          id: 'charts',
          title: 'Charts',
          type: 'item',
          url: '/charts/nvd3',
          icon: 'feather icon-pie-chart',
        },
      ],
    },
  ],
}

export default menuItems
