import React, {useState, useContext} from 'react'
import {ListGroup, Dropdown} from 'react-bootstrap'
import {Link} from 'react-router-dom'
import {AuthContext} from '../../../../contexts'

const NavRight: React.FC = () => {
  const [listOpen, setListOpen] = useState(false)
  const {signOut, getCurrentAccount} = useContext(AuthContext)

  return (
    <>
      <ListGroup
        as="ul"
        bsPrefix=" "
        className="navbar-nav ml-auto"
        id="navbar-right">
        <ListGroup.Item as="li" bsPrefix=" ">
          <Dropdown className="drp-user">
            <Dropdown.Toggle
              as={Link}
              variant="link"
              to="#"
              id="dropdown-basic">
              <i className="icon feather icon-settings" />
            </Dropdown.Toggle>
            <Dropdown.Menu alignRight className="profile-notification">
              <div className="pro-head">
                <span>{getCurrentAccount()?.name}</span>
                <Link
                  to="#"
                  className="dud-logout"
                  title="Logout"
                  onClick={signOut}>
                  <i className="feather icon-log-out" />
                </Link>
              </div>
              <ListGroup
                as="ul"
                bsPrefix=" "
                variant="flush"
                className="pro-body">
                <ListGroup.Item as="li" bsPrefix=" ">
                  <Link to="#" className="dropdown-item">
                    <i className="feather icon-settings" /> Conta
                  </Link>
                </ListGroup.Item>
                <ListGroup.Item as="li" bsPrefix=" ">
                  <Link to="#" className="dropdown-item" onClick={signOut}>
                    <i className="feather icon-log-out" /> Sair
                  </Link>
                </ListGroup.Item>
              </ListGroup>
            </Dropdown.Menu>
          </Dropdown>
        </ListGroup.Item>
      </ListGroup>
    </>
  )
}

export default NavRight
