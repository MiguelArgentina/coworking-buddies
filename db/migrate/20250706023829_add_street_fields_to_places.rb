class AddStreetFieldsToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :street_name, :string
    add_column :places, :street_number, :string
  end
end
