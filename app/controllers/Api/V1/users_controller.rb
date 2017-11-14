class Api::V1::UsersController < ApplicationController

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.create(user_params)
    render json: user
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end

  private

  def user_params
    params.require(:user).permit(:company, :firstname, :lastname, :email, :password)
  end

end
