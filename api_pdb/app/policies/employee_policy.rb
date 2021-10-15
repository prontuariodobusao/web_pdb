class EmployeePolicy < ApplicationPolicy
  def admin_or_rh?
    user.has_role?(:admin) || user.has_role?(:rh)
  end

  def admin?
    user.has_role?(:admin)
  end

  def admin_or_visitor?
    user.has_role?(:admin) || user.has_role?(:visitor)
  end
end
