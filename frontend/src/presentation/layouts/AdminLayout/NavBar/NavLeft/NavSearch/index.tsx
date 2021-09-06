import React, {useState} from 'react'
import {Link} from 'react-router-dom'

type TypeProps = {
  windowWidth: any
}

const NavSearch: React.FC<TypeProps> = ({windowWidth}: TypeProps) => {
  const [isOpen, setIsOpen] = useState(windowWidth < 600)
  const [searchString, setSearchString] = useState<any>(
    windowWidth < 600 ? '100px' : '',
  )

  const searchOnHandler = () => {
    if (windowWidth < 600) {
      document.querySelector<any>('#navbar-right').classList.add('d-none')
    }
    setIsOpen(true)
    setSearchString('100px')
  }

  const searchOffHandler = () => {
    setIsOpen(false)
    setSearchString(0)
    setTimeout(() => {
      if (windowWidth < 600) {
        document.querySelector<any>('#navbar-right').classList.remove('d-none')
      }
    }, 500)
  }

  let searchClass = ['main-search']
  if (isOpen) {
    searchClass = [...searchClass, 'open']
  }

  return (
    <>
      <div id="main-search" className={searchClass.join(' ')}>
        <div className="input-group">
          <input
            type="text"
            id="m-search"
            className="form-control"
            placeholder="Search . . ."
            style={{width: searchString}}
          />
          <Link
            to="#"
            className="input-group-append search-close"
            onClick={searchOffHandler}>
            <i className="feather icon-x input-group-text" />
          </Link>
          <span
            className="input-group-append search-btn btn btn-primary"
            onClick={searchOnHandler}>
            <i className="feather icon-search input-group-text" />
          </span>
        </div>
      </div>
    </>
  )
}

export default NavSearch
