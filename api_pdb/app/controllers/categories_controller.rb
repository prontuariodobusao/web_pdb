class CategoriesController < ApplicationController
  def problems
    category = Category.find(params[:id])

    json_response category.problems.select(:id, :description)
  end
end
