import React, {useState, useEffect} from 'react'
import {ListGroup} from 'react-bootstrap'
import {Link} from 'react-router-dom'

import navigation from '../../../menu-items'
import {BASE_TITLE, BASENAME} from '../../../config/constant'

const Breadcrumb: React.FC = () => {
  const [main, setMain] = useState<any>([])
  const [item, setItem] = useState<any>([])

  useEffect(() => {
    navigation.items.map((item, index) => {
      if (item.type && item.type === 'group') {
        getCollapse(item, index)
      }
      return false
    })
  })

  const getCollapse = (item: any, index: any) => {
    if (item.children) {
      item.children.filter((collapse: any) => {
        if (collapse.type && collapse.type === 'collapse') {
          getCollapse(collapse, index)
        } else if (collapse.type && collapse.type === 'item') {
          if (document.location.pathname === BASENAME + collapse.url) {
            setMain(item)
            setItem(collapse)
          }
        }
        return false
      })
    }
  }

  let mainContent, itemContent
  let breadcrumbContent: any = ''
  let title = ''

  if (main && main.type === 'collapse') {
    mainContent = (
      <ListGroup.Item as="li" bsPrefix=" " className="breadcrumb-item">
        <Link to="#">{main.title}</Link>
      </ListGroup.Item>
    )
  }

  if (item && item.type === 'item') {
    title = item.title
    itemContent = (
      <ListGroup.Item as="li" bsPrefix=" " className="breadcrumb-item">
        <Link to="#">{title}</Link>
      </ListGroup.Item>
    )

    if (item.breadcrumbs !== false) {
      breadcrumbContent = (
        <div className="page-header">
          <div className="page-block">
            <div className="row align-items-center">
              <div className="col-md-12">
                <div className="page-header-title">
                  <h5 className="m-b-10">{title}</h5>
                </div>
                <ListGroup as="ul" bsPrefix=" " className="breadcrumb">
                  <ListGroup.Item
                    as="li"
                    bsPrefix=" "
                    className="breadcrumb-item">
                    <i className="feather icon-home" />

                    {/* <Link to="/inicio">
                      <i className="feather icon-home" />
                    </Link> */}
                  </ListGroup.Item>
                  {mainContent}
                  {itemContent}
                </ListGroup>
              </div>
            </div>
          </div>
        </div>
      )
    }

    document.title = title + BASE_TITLE
  }

  return <>{breadcrumbContent}</>
}

export default Breadcrumb
