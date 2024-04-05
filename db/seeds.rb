# Generate Genres
puts 'Removing all genres from the DB...'
Genre.destroy_all
puts 'Getting all genres'

genres_info = [
  { name: 'Japanese' },
  { name: 'Italian' },
  { name: 'Indian' }
]
# genres = genres_info.map { |info| Genre.new(info) }

genres_info.each do |info|
  Genre.create(info)
end

puts 'Genres have been created'

# Generate Restaurants
require 'json'

puts 'Removing all restaurants from the DB...'
Restaurant.destroy_all
puts 'Getting the restaurants from the local JSON file...'

file_path = Rails.root.join('db', 'seeds', 'restaurants.json')

json_restaurants = File.read(file_path)
restaurants = JSON.parse(json_restaurants)

restaurants['restaurants'].each do |restaurant_hash|
  puts "Creating #{restaurant_hash['name']}..."
  Restaurant.create!(
    name: restaurant_hash['name'],
    address: restaurant_hash['address'],
    genre_id: restaurant_hash['genre_id']
  )
end

puts "...created #{Restaurant.count} restaurants!"

# Generate vehicles
puts 'removing all vehicles from DB...'
Vehicle.destroy
puts 'getting all vehicles'

vehicles_info = [
  { type: 'car' },
  { type: 'motorcycle' },
  { type: 'bicycle' },
  { type: 'foot' }
]

vehicles_info.each do |info|
  Vehicle.create(info)
end

# Generate delivery_staff
puts 'Removing all deliver_staff from the DB...'
DeliveryStaff.destroy_all
puts 'Getting all deliver_staff'

20.times do |n|
  DeliveryStaff.create!(
    name: "#{Faker::Name.unique.first_name} #{Faker::Name.unique.last_name}",
    vehicle_id: rand(1..4)
  )
end
