class EventParticipationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @participation = @event.event_participations.find_or_create_by(user: current_user)
    @event.reload

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @event, notice: "You're attending this event!" }
    end
  end

  def destroy
    @participation = @event.event_participations.find_by(user: current_user)
    @participation&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @event, notice: "You left the event." }
    end
  end

  private

  def set_event
    @event = Event.friendly.find(params[:event_id])
  end
end
