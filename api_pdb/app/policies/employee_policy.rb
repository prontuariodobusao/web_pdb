class EmployeePolicy < ApplicationPolicy
  def admin_or_rh?
    user.has_role?(:admin) || user.has_role?(:rh)
  end
end
