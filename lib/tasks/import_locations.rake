# lib/tasks/import_locations.rake
namespace :import do
  desc "Import countries, states, and cities from CSV"
  task cities: :environment do
    require 'csv'

    path = Rails.root.join("db", "data", "cities.csv") # rename if needed
    puts "Importing from #{path}..."

    CSV.foreach(path, headers: true) do |row|
      country = Country.find_or_create_by!(name: row["country_name"], code: row["country_code"])
      state   = State.find_or_create_by!(name: row["state_name"], code: row["state_code"], country: country)
      City.find_or_create_by!(
        name: row["name"],
        state: state,
        latitude: row["latitude"],
        longitude: row["longitude"]
      )
    end

    puts "Import complete!"
  end
end
