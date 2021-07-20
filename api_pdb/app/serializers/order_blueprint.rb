class OrderBlueprint < Blueprinter::Base
  identifier :id

  fields :reference

  view :list do
    field :status_id
    field :status_name, name: :status
    field :created_at, datetime_format: '%d/%m/%Y'
    field :problem_category_id, name: :category_id
  end

  view :show do
    include_view :list
    field :problem_description, name: :problem
    field :vehicle_car_number, name: :car_number
    field :category_name do |order|
      order.problem.category_name
    end
    field :employee_name do |order|
      order.owner.employee_name
    end
  end
end
