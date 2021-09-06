import {useRef, useEffect} from 'react'

const useScriptRef = (): any => {
  const scripted = useRef(true)

  useEffect(
    () => () => {
      scripted.current = false
    },
    [],
  )

  return scripted
}

export default useScriptRef
