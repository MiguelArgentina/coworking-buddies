class Place < ApplicationRecord
  RECENT_PERIOD = 6.months

  belongs_to :user
  belongs_to :country
  belongs_to :state
  has_many :events, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :name, :city, :street_name, :street_number, :country_id, :state_id, presence: true
  validate :must_have_coordinates

  #geocoded_by :full_address
  #after_validation :geocode

  def full_address
    [
      street_name,
      street_number,
      city,
      state&.name,
      country&.name
    ].compact.reject(&:blank?).join(', ')
  end

  def total_score_percentage
    return 0 if total_votes.zero?

    ((total_score.to_f / total_votes) * 100).round
  end

  def recent_score_percentage
    return 0 if recent_votes.zero?

    ((recent_score.to_f / recent_votes) * 100).round
  end

  def total_score
    top_down_to_zero(votes.sum(:value))
  end

  def recent_score
    top_down_to_zero(votes.where("created_at >= ?", RECENT_PERIOD.ago).sum(:value))
  end

  def total_votes
    votes.count
  end

  def recent_votes
    votes.where("created_at >= ?", RECENT_PERIOD.ago).count
  end

  def top_down_to_zero(value)
    [value, 0].max
  end

  def must_have_coordinates
    if latitude.blank? || longitude.blank?
      errors.add(:base, "Please choose a valid location from the list.")
    end
  end
end
