import React from 'react'
import ReactDOM from 'react-dom'
import Routes from './main/routes/routes'
import reportWebVitals from './reportWebVitals'
import {ConfigProvider} from 'presentation/contexts/ConfigContext'
import 'presentation/styles/index.scss'

ReactDOM.render(
  <React.StrictMode>
    <ConfigProvider>
      <Routes />
    </ConfigProvider>
  </React.StrictMode>,
  document.getElementById('root'),
)

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals()
