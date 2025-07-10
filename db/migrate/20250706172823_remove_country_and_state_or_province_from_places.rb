class RemoveCountryAndStateOrProvinceFromPlaces < ActiveRecord::Migration[7.1]
  def change
    remove_column :places, :country, :string
    remove_column :places, :state_or_province, :string
  end
end
