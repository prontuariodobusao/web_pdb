import React, {ReactNode} from 'react'

type Props = {
  animationDuration: number
  children: ReactNode
  isFinished: boolean
}

const Container: React.FC<Props> = ({
  animationDuration,
  children,
  isFinished,
}: Props) => {
  return (
    <div
      style={{
        opacity: isFinished ? 0 : 1,
        pointerEvents: 'none',
        transition: `opacity ${animationDuration}ms linear`,
      }}>
      {children}
    </div>
  )
}

export default Container
