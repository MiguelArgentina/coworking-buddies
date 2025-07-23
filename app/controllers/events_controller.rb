class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: [:show]
  before_action :set_user_event, only: [:edit, :update, :destroy]

  def index
    @events = Event.order(start_time: :asc)
  end

  def show
    @participation = @event.event_participations.find_by(user: current_user)
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to event_path(@event), notice: "Event created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event removed."
  end

  private

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def set_user_event
    @event = current_user.events.friendly.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :duration_amount, :duration_unit, :place_id, :recurrence_rule, tag_ids: [])
  end
end
