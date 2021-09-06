class OrderPolicy < ApplicationPolicy
  def admin?
    user.has_role?(:admin)
  end
end
