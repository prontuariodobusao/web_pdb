# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :index
  before_action :set_user, only: %i[show update]

  def index
    users = User.page(current_page).per_page(per_page)

    options = pagination_meta_generator(request, users.total_pages)

    json_response UserBlueprint.render(users, root: :data, meta: options)
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
        :email,
        :password,
        :password_confirmation
      )
  end
end
