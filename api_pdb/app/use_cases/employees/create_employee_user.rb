module Employees
  class CreateEmployeeUser
    include UseCase

    def initialize(employee:)
      @employee = employee
    end

    def call
      create
    end

    private

    attr_accessor :employee

    def create
      password = "#{SecureRandom.alphanumeric(5).downcase}3"
      employee.transaction do
        employee.save!
        # create user
        employee.create_user!(user_attr(password)) if employee.is_user
      end

      success({ employee: employee, password: password })
    end

    def user_attr(password)
      {
        username: employee.identity,
        password: password,
        password_confirmation: password
      }
    end
  end
end
