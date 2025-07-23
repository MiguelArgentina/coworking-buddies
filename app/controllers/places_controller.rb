class PlacesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_place, only: [:edit, :update, :destroy]

  def index
    @places = Place.includes(:user).order(name: :asc)
  end

  def new
    @place = current_user.places.build
  end

  def create
    @place = current_user.places.build(place_params)
    if @place.save
      redirect_to places_path, notice: "Place successfully added!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @states = State.where(country_id: @place.country_id)
    @cities = City.where(state_id: @place.state_id)
  end

  def update
    if @place.update(place_params)
      redirect_to places_path, notice: "Place updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @place = Place.includes(:user).friendly.find(params[:id])
    @events = @place.events.order(start_time: :asc)
    @event = @place.events.build
  end

  def destroy
    @place.destroy
    redirect_to places_path, notice: "Place removed."
  end

  private

  def set_place
    @place = current_user.places.friendly.find(params[:id])
  end

  def place_params
    params.require(:place).permit(:name, :street_number, :street_name, :city,:country_id, :state_id, :description, :latitude, :longitude, :tag_list)
  end
end
