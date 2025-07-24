# db/seeds.rb
require "faker"

puts "🌱 Seeding database..."

# Clean up
EventParticipation.delete_all
Event.delete_all
Place.delete_all
User.delete_all
City.delete_all
State.delete_all
Country.delete_all

# Create countries, states, cities
3.times do
  country = Country.create!(name: Faker::Address.unique.country, code: Faker::Address.unique.country_code)

  state = State.create!(
    name: Faker::Address.state,
    code: Faker::Address.state_abbr,
    country: country
  )

  city = City.create!(
    name: Faker::Address.city,
    state: state,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  )
end

cities = City.includes(:state, :country).all

# Users
users = 5.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
    address: Faker::Address.full_address
  )
end

# Places
places = 6.times.map do
  city = cities.sample

  place = Place.new(
    name: Faker::Company.name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    street_name: Faker::Address.street_name,
    street_number: Faker::Address.building_number,
    city: city.name,
    state: city.state,
    country: city.state.country,
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user: users.sample
  )
  place.tag_list = Faker::Lorem.words(number: Random.rand(1..5)).join(", ")
  place.save!
  place
end

# Events
events = []
places.each do |place|
  2.times do
    start_time = Faker::Time.between(from: 1.hour.from_now, to: 10.days.from_now)
    end_time = start_time + [1, 2, 3].sample.hours

    event = Event.new(
      title: Faker::Hipster.sentence(word_count: 3),
      description: Faker::Hipster.paragraph,
      start_time: start_time,
      end_time: end_time,
      user: place.user,
      place: place
    )
    event.tag_list = Faker::Lorem.words(number: Random.rand(1..5)).join(", ")
    event.save!
    events << event
  end
end

# Event Participations
events.sample(5).each do |event|
  rand(1..3).times do
    EventParticipation.create!(
      user: users.reject { |u| u == event.user }.sample,
      event: event,
      joined_at: Time.current
    )
  end
end

puts "✅ Seeding complete!"
