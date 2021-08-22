class EmployeeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity
  field :occupation do |employee|
    employee.occupation_type_occupation
  end
  field :confirmation do |employee|
    employee.user.confirmed?
  end
end
