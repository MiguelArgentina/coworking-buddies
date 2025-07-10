class AddLocationToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_reference :places, :country, null: false, foreign_key: true
    add_reference :places, :state, null: false, foreign_key: true
  end
end
