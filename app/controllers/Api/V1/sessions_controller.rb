class Api::V1::SessionsController < ApplicationController

  before_action :authorize_user!, only: [:show]

  def show
    render json: {
      id: current_user.id,
      company: current_user.company,
      firstname: current_user.firstname,
      lastname: current_user.lastname,
      email: current_user.email
    }
  end

  def create
    user = User.find_by(company: params[:company])
    if user.present? && user.authenticate(params[:password])
      render json: {
        id: user.id,
        email: user.email,
        firstname: user.firstname,
        lastname: user.lastname,
        company: user.company,
        jwt: JWT.encode({id: user.id}, "planningCalendar")
      }
    else
      render json: {
        error: "Please login with the correct credentials!"
      }, status: 404
    end
  end

end
