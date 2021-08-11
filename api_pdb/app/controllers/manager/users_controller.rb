# app/controllers/users_controller.rb
module Manager
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update unlock]
    before_action :autorize_manager_or_rh

    def show
      json_response serializer_blueprint(:user, @user)
    end

    def create
      user = User.create!(user_params)
      json_response_create(OrderBlueprint.render(user, root: :data, meta: { links: links(user) }),
                           manager_user_url(user))
    end

    def unlock
      user = Users::Unlock.call(user: @user, attributes: user_params)[:data][:user]
      json_response serializer_blueprint(:user, user)
    end

    def update
      @user.update!(user_params)
      head :no_content
    end

    private

    def autorize_manager_or_rh
      authorize Employee, :admin_or_rh?
    end

    def links(user)
      { self: manager_user_url(user) }
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params
        .require(:data)
        .permit(
          :username,
          :password,
          :password_confirmation
        )
    end
  end
end
