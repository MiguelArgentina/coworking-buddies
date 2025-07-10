class Locations::LookupsController < ApplicationController
  before_action :authenticate_user!, except: [:geocode, :states, :cities]

  def states
    states = State.where(country_id: params[:country_id]).order(:name)
    render json: states.select(:id, :name)
  end

  def cities
    cities = City.where(state_id: params[:state_id]).order(:name)
    render json: cities.select(:id, :name)
  end

  def geocode
    query = params[:q].to_s.strip
    return render json: [] if query.blank?

    url = URI("https://nominatim.openstreetmap.org/search?format=json&q=#{URI.encode_www_form_component(query)}")

    response = Net::HTTP.get_response(url)
    render json: JSON.parse(response.body)
  end
end
