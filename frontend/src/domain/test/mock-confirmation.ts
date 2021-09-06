import faker from 'faker'
import {UserDataModel} from '../models/user-model'
import {ConfirmDataParams} from '../usecases/confirm/confirmation'
import {DataTableParams} from '../../domain/usecases/remote-datatable'
import {EmployeeParams} from '../../domain/usecases/employees/create-employee'
import {EmployeeEditParams} from '../../domain/usecases/employees/edit-employee'
import {RoleParams} from '../usecases/users/add-or-remove-roles/add-or-remove-roles'

export const mockRoleParams = (): RoleParams => ({
  data: {
    name: 'admin',
  },
})

export const mockUserDataModel = (): UserDataModel => ({
  data: {
    id: '1',
    confirmation: true,
    username: 'user_1',
    employee_name: 'Fulano',
    occupation: 'manager',
    roles: [{id: 1, name: 'admin'}],
  },
})

export const mockConfirmationParams = (): ConfirmDataParams => {
  const password: string = faker.internet.password()

  return {
    data: {
      password: password,
      password_confirmation: password,
    },
  }
}

export const mockEmployeeDataTableParams = (): DataTableParams => {
  return {
    draw: 1,
    page: 1,
    per_page: 10,
    sort_field: null,
    sort_direction: 'asc',
    search_value: '',
  }
}

export const mockCreateEmployeeParams = (): EmployeeParams => {
  return {
    data: {
      name: 'Nome teste',
      identity: '1234',
      occupation_id: 1,
      is_user: true,
    },
  }
}

export const mockEditEmployeeParams = (): EmployeeEditParams => {
  return {
    data: {
      name: 'Nome teste',
      identity: '1234',
      occupation_id: 1,
    },
  }
}

export const mockConfirmationModel = (): UserDataModel => mockUserDataModel()
