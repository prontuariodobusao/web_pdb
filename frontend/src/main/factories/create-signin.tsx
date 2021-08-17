import React from 'react'
import {SignIn} from '../../presentation/pages'
import {RemoteAuth} from '../../data/usecases'
import {AxiosHttpClient} from '../../infra/http'
import {basUrl} from '../../services'

const httpClient = new AxiosHttpClient()
const remoteAuth = new RemoteAuth(`${basUrl}/auth/login`, httpClient)

export const createSignIn: React.FC = () => (
  <SignIn authentication={remoteAuth} />
)
