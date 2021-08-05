class EmployeeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity, :driver_license
  field :admission_date, datetime_format: '%d/%m/%Y'
  field :occupation do |employee|
    employee.occupation_type_occupation
  end
end
