module Employees
  class CreateEmployeeUser
    include UseCase

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
          add_role_to_employee(new_user)
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

    def add_role_to_employee(user)
      case employee.occupation_type_occupation
      when 'driver'
        user.add_role :driver
      when 'manager'
        user.add_role :admin
      when 'rh'
        user.add_role :rh
      when 'visitor'
        user.add_role :visitor
      else
        user.add_role :normal
      end
    end
  end
end
