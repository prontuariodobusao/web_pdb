import {useEffect, useState} from 'react'

type WindowState = {
  width: any
  height: any
}

const useWindowSize = (): WindowState => {
  const [windowSize, setWindowSize] = useState<WindowState>({} as WindowState)

  useEffect(() => {
    function handleResize() {
      setWindowSize({
        width: window.innerWidth,
        height: window.innerHeight,
      })
    }
    window.addEventListener('resize', handleResize)
    handleResize()

    return () => window.removeEventListener('resize', handleResize)
  }, [])

  return windowSize
}

export default useWindowSize
