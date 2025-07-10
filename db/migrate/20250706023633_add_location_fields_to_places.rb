class AddLocationFieldsToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :city, :string
    add_column :places, :state_or_province, :string
    add_column :places, :country, :string
  end
end
