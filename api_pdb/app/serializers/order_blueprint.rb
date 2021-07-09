class OrderBlueprint < Blueprinter::Base
  identifier :id

  fields :km, :state, :description

  field :problem_description, name: :problem
  field :status_name, name: :status
  field :vehicle_car_number, name: :car_number
end
