class EmployeePolicy < ApplicationPolicy
  def manager_or_rh?
    user.employee.occupation_type_occupation == 'manager' || user.employee.occupation_type_occupation == 'rh'
  end
end
