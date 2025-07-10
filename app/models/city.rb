# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  latitude   :float
#  longitude  :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state_id   :bigint           not null
#
# Indexes
#
#  index_cities_on_state_id  (state_id)
#
# Foreign Keys
#
#  fk_rails_...  (state_id => states.id)
#
class City < ApplicationRecord
  belongs_to :state
  has_one :country, through: :state
end
