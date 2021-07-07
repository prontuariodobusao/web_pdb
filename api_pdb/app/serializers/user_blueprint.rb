class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :username, :employee_name
  field :confirmed?, name: :confirmation
end
