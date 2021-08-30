class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :username, :employee_name
  field :confirmed?, name: :confirmation
  field :employee_name do |user|
    user.employee_name
  end
  association :roles, blueprint: RoleBlueprint

  field :occupation do |user|
    user.employee.occupation_type_occupation
  end
end
