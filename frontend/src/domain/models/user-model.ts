export type UserModel = {
  id: string
  confirmation?: boolean
  username?: string
  employee_name: string
  occupation: string
}

export type UserDataModel = {
  data: UserModel
}

export type UserWithPasswordModel = {
  user: {
    data: {
      id: 0
      username: string
      employee_name: string
      occupation: string
      confirmation: true
    }
    meta: {
      links: {
        self: string
      }
    }
  }
  password: string
}
