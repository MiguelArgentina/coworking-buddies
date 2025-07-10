# == Schema Information
#
# Table name: user_follows
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :bigint           not null
#  follower_id :bigint           not null
#
# Indexes
#
#  index_user_follows_on_followed_id  (followed_id)
#  index_user_follows_on_follower_id  (follower_id)
#
# Foreign Keys
#
#  fk_rails_...  (followed_id => users.id)
#  fk_rails_...  (follower_id => users.id)
#
class UserFollow < ApplicationRecord
  belongs_to :follower
  belongs_to :followed
end
