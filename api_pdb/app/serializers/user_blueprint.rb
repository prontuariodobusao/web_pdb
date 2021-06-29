class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :identity
  field :confirmed?, name: :confirmation
end
