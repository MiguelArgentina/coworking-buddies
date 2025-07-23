class HomeController < ApplicationController
  def index
    @places = Place.includes(:state).order(created_at: :desc).limit(10)
    @events = Event.includes(:place).order(start_time: :asc).limit(10)
  end
end
