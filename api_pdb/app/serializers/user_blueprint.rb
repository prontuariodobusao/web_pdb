class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity, :email, :cpf
end
