class CategoriesController < ApplicationController
  def problems
    category = Category.find(params[:id])
    problems = category.problems.select(:id, :description)
    vehicles = Vehicle.select(:id, :car_number)

    json_response({ vehicles: vehicles, problems: problems })
  end
end
