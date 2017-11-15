class Api::V1::EventsController < ApplicationController

  def index
    events = Event.all
    render json: events
  end

  def create
    event = Event.create(event_params)
    current_user.events << event
    render json: event
  end

  def show
    event = Event.find_by(id: params[:id])
    render json: event
  end

  def destroy
    event = Event.find_by(id: params[:id])
    event.destroy
    render json: event
  end

  private

  def event_params
    params.require(:user).permit(:title, :allDay, :start, :end, :user_id)
  end

end
