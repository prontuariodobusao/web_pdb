class EmployeeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity
  field :occupation do |employee|
    employee.occupation_type_occupation
  end
end
