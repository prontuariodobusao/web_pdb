import React from 'react'
import {BrowserRouter as Router} from 'react-router-dom'

import routes, {renderRoutes} from './routes/routes'
import {BASENAME} from '../presentation/config/constant'

const App: React.FC = () => (
  <Router basename={BASENAME}>{renderRoutes(routes)}</Router>
)

export default App
