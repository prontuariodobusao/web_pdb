class ConfirmationsController < ApplicationController
  before_action :set_user, only: :create

  def create
    user = Users::ConfirmFirstAccess.call(user: @user, attributes: confirmation_params).data[:user]

    render json: UserBlueprint.render(user, root: :data), status: :created
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def confirmation_params
    params.require(:data).permit(:password, :password_confirmation)
  end
end
