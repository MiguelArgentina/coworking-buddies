class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_place

  def create
    @vote = @place.votes.find_or_initialize_by(user: current_user)
    total_votes = @place.total_votes
    new_value = vote_params[:value].to_i
    vote_type = new_value == 1 ? "upvote" : "downvote"

    # Prevent voting if the user has already voted with the same value
    if @vote.persisted? && @vote.value == new_value
      redirect_back fallback_location: place_path(@place), notice: "You have already #{vote_type}d this place."
      return
    end
    # Prevent downvoting if total votes are 0 and user hasn't voted yet
    if new_value == -1 && total_votes == 0
      message = "You cannot downvote a place with no votes, but you can always leave a reference."
      redirect_back fallback_location: place_path(@place), alert: message
      return
    end

    @vote.value = new_value

    if @vote.save
      redirect_back fallback_location: place_path(@place), notice: "Thanks for your feedback!"
    else
      redirect_back fallback_location: place_path(@place), alert: "Unable to register your vote."
    end
  end

  private

  def set_place
    @place = Place.find(params[:place_id])
  end

  def vote_params
    params.permit(:value)
  end
end
