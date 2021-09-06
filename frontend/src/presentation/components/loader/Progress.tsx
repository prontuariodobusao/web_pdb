import React from 'react'
import {withNProgress} from '@tanem/react-nprogress'

import Bar from './Bar'
import Container from './Container'
import Spinner from './Spinner'

type Props = {
  isFinished: boolean
  progress: number
  animationDuration: number
}

const Progress: React.FC<Props> = ({
  isFinished,
  progress,
  animationDuration,
}: Props) => {
  return (
    <Container animationDuration={animationDuration} isFinished={isFinished}>
      <Bar animationDuration={animationDuration} progress={progress} />
      <Spinner />
    </Container>
  )
}

export default withNProgress(Progress)
