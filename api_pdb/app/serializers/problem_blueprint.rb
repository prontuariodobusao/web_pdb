class ProblemBlueprint < Blueprinter::Base
  identifier :id

  fields :description, :priority

  association :category, blueprint: CategoryBlueprint
end
