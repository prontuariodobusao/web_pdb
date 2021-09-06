# app/controllers/users_controller.rb
module Manager
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update unlock reset_password add_or_remove_role]
    before_action :autorize_manager_or_rh

    def show
      json_response UserBlueprint.render(@user, root: :data, meta: { links: links(@user) })
    end

    def create
      employee = Employee.find(params[:employee_id])
      result = Employees::CreateUser.call(employee: employee)

      json_response({
                      user: UserBlueprint.render_as_hash(result[:data][:user],
                                                         root: :data,
                                                         meta: { links: links(result[:data][:user]) }),
                      password: result[:data][:password]
                    }, :created)
    end

    def unlock
      user = Users::Unlock.call(user: @user, attributes: user_params)[:data][:user]
      json_response serializer_blueprint(:user, user)
    end

    def reset_password
      result = Users::ResetPassword.call(user: @user)
      json_response({
                      user: UserBlueprint.render_as_hash(result[:data][:user],
                                                         root: :data,
                                                         meta: { links: links(result[:data][:user]) }),
                      password: result[:data][:password]
                    })
    end

    def update
      @user.update!(user_params)
      head :no_content
    end

    def add_or_remove_role
      role = params.require(:data).permit(:name)
      @user.add_or_remove_role role[:name]

      json_response UserBlueprint.render(@user, root: :data)
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
  end
end
