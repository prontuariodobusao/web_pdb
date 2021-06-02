# app/controllers/initial_controller.rb
class InitialController < ApplicationController
  def index
    render json: { message: 'Bem vindo ao Prontuario do Busão/Backend!!' }
  end
end
