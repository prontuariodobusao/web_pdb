module Employees
  class CreateUser
    include UseCase
    include AddRoleToUsers

    def initialize(employee:)
      @employee = employee
      @password = "#{SecureRandom.alphanumeric(5).downcase}3"
    end

    def call
      create
    end

    private

    attr_accessor :employee, :password

    def create
      employee.transaction do
        employee.create_user!(user_params)
        add_role_to_employee(employee.user, employee)
      end

      success({ user: employee.user, password: password })
    end

    def user_params
      {
        username: employee.identity,
        password: password,
        password_confirmation: password
      }
    end
  end
end
