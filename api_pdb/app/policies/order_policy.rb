class OrderPolicy < ApplicationPolicy
  def manager?
    user.employee.occupation_type_occupation == 'manager'
  end
end
