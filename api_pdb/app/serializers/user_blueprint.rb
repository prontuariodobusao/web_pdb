class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :username, :employee_name
  field :confirmed?, name: :confirmation
  field :employee_name do |user|
    user.employee_name
  end
end
