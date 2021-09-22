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
    field :created_at, datetime_format: '%d/%m/%Y'
    association :vehicle, blueprint: VehicleBlueprint
    association :status, blueprint: StatusBlueprint
    association :problem, blueprint: ProblemBlueprint
    association :owner, blueprint: UserBlueprint
  end

  view :show_manager do
    include_view :show
    field :description
    association :solution, blueprint: SolutionBlueprint
    association :manager, blueprint: EmployeeBlueprint
    association :car_mecanic, blueprint: EmployeeBlueprint
  end

  view :panel do
    field :problem_description, name: :description
    field :status_name, name: :status
    field :category_id do |order|
      order.problem.category_id
    end
    field :category do |order|
      order.problem.category_name
    end
    field :mecanic do |order|
      order.car_mecanic.name
    end
    field :owner do |order|
      order.owner.employee_name
    end
  end
end
