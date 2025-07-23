# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  description :text
#  end_time    :datetime
#  slug        :string
#  start_time  :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  place_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_events_on_place_id  (place_id)
#  index_events_on_slug      (slug) UNIQUE
#  index_events_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (place_id => places.id)
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
  extend FriendlyId

  acts_as_taggable_on :tags

  friendly_id :title, use: :slugged

  attr_accessor :duration_amount, :duration_unit

  belongs_to :user
  belongs_to :place
  has_many :event_participations, dependent: :destroy
  has_many :attendees, through: :event_participations, source: :user
  has_many :event_comments, dependent: :destroy

  before_validation :set_end_time_from_duration

  validates :title, :start_time, presence: true
  validate :start_time_cannot_be_in_the_past

  broadcasts_to ->(event) { event }, inserts_by: :prepend

  def google_calendar_link
    base_url = "https://www.google.com/calendar/render?action=TEMPLATE"
    params = {
      text: title,
      details: description,
      location: place.full_address,
      dates: "#{start_time.utc.strftime('%Y%m%dT%H%M%SZ')}/#{end_time.utc.strftime('%Y%m%dT%H%M%SZ')}"
    }
    "#{base_url}&#{params.to_query}"
  end

  def attending?(user)
    event_participations.exists?(user_id: user.id)
  end

  def start_time_cannot_be_in_the_past
    if start_time.present? && start_time < Time.current
      errors.add(:start_time, "can't be in the past")
    end
  end

  def set_end_time_from_duration
    return if start_time.blank? || duration_amount.blank? || duration_unit.blank?

    minutes = duration_unit == "hours" ? duration_amount.to_i * 60 : duration_amount.to_i
    self.end_time = start_time + minutes.minutes
  end
end
