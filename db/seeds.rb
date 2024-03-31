# Generate Restaurant
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
