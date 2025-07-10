# == Schema Information
#
# Table name: event_comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_event_comments_on_event_id  (event_id)
#  index_event_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#  fk_rails_...  (user_id => users.id)
#
class EventComment < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
