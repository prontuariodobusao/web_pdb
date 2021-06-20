class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity, :locked?
end
