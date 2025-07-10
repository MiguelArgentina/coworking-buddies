# == Schema Information
#
# Table name: event_participations
#
#  id         :bigint           not null, primary key
#  joined_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_event_participations_on_event_id  (event_id)
#  index_event_participations_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
class EventParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
