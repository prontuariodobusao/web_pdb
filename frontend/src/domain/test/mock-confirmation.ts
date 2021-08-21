import faker from 'faker'
import {UserDataModel} from '../models/user-model'
import {ConfirmDataParams} from '../usecases/confirm/confirmation'
import {EmployeeDataTableParams} from '../usecases/employees/employee-datatable'

export const mockUserDataModel = (): UserDataModel => ({
  data: {
    id: '1',
    confirmation: true,
    username: 'user_1',
    employee_name: 'Fulano',
    occupation: 'manager',
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

export const mockEmployeeDataTableParams = (): EmployeeDataTableParams => {
  return {
    draw: 1,
    page: 1,
    per_page: 10,
    sort_field: null,
    sort_direction: 'asc',
    search_value: '',
  }
}

export const mockConfirmationModel = (): UserDataModel => mockUserDataModel()
