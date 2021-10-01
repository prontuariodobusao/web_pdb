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
          title: 'Visão Geral',
          type: 'item',
          url: '/dashboard',
          icon: 'feather icon-home',
        },
        {
          id: 'panel',
          title: 'Painel Mecânicos',
          type: 'item',
          url: '/panel',
          icon: 'feather icon-file-text',
        },
        {
          id: 'chart',
          title: 'Indicadores',
          type: 'item',
          url: '/indicadores',
          icon: 'feather icon-pie-chart',
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
            {
              id: 'vehicles',
              title: 'Veículos',
              type: 'item',
              url: '/veiculos',
            },
          ],
        },
      ],
    },
  ],
}

export default menuItems
