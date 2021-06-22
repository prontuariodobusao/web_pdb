class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity, :confirmed?, :unlocked?
end
