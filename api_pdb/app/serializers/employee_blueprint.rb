class EmployeeBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity
  field :occupation_id
  field :occupation do |employee|
    case employee.occupation_type_occupation
    when 'driver'
      'Motorista'
    when 'mecanic'
      'Mecãnico'
    when 'manager'
      'Gerente'
    when 'rh'
      'RH'
    else
      employee.occupation_type_occupation
    end
  end
  field :confirmation do |employee|
    if employee.user && employee.user.confirmed? == true
      'Sim'
    elsif employee.user && employee.user.confirmed? == false
      'Não'
    else
      'N/L'
    end
  end
  association :user, blueprint: UserBlueprint
end
