module Employees
  class CreateEmployeeUser
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
        employee.save!
        # create user
        if employee.is_user
          new_user.save!
          add_role_to_employee(new_user, employee)
        end
      end

      success({ employee: employee, password: password })
    end

    def new_user
      User.new(
        username: employee.identity,
        password: password,
        password_confirmation: password,
        employee: employee
      )
    end
  end
end
