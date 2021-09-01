module AddRoleToUsers
  extend ActiveSupport::Concern

  def add_role_to_employee(user, employee)
    case employee.occupation_type_occupation
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
