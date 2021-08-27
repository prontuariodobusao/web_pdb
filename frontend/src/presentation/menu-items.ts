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
      ],
    },
    {
      id: 'resource',
      title: 'Cadastros',
      type: 'group',
      icon: 'icon-ui',
      children: [
        {
          id: 'basic',
          title: 'Cadastros',
          type: 'collapse',
          icon: 'feather icon-plus-square',
          children: [
            {
              id: 'workers',
              title: 'Funcionários',
              type: 'item',
              url: '/funcionarios',
            },
          ],
        },
      ],
    },
  ],
}

export default menuItems
