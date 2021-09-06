import React, {useState, useEffect} from 'react'

const DataTableLoading: React.FC = () => {
  const [state, setState] = useState({
    styles: {
      width: 0,
      position: 'fixed',
      display: 'block',
      height: '2px',
      background: '#0076ff',
      top: 0,
      left: 0,
      transform: 'translate3d(0, 0, 0)',
      zIndex: 9999,
      transition: 'width 300ms ease-out, opacity 150ms 150ms ease-in',
    },
  })

  useEffect(() => {
    const value = 1

    setState({
      ...state,
      styles: {
        ...state.styles,
        width: 10 + value * 90,
      },
    })
    setInterval(increment.bind(this), 50)
  }, [])

  const increment = () => {
    const value = 45
    setState({
      ...state,
      styles: {
        ...state.styles,
        width: state.styles.width + (value + Math.random() / 100),
      },
    })
  }
  return <div style={state.styles as any} />
}

export default DataTableLoading
