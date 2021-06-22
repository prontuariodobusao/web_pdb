# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user, only: %i[show update]

  def index
    users = User.page(current_page).per_page(per_page)

    options = pagination_meta_generator(request, users.total_pages)

    json_response UserBlueprint.render(users, root: :data, meta: options)
  end

  def show
    json_response UserBlueprint.render(@user, root: :data)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params
      .require(:data)
      .require(:attributes)
      .permit(
        :name,
        :identity,
        :password,
        :password_confirmation
      )
  end
end
