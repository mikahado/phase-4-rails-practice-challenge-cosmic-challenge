# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Clearing db..."
Planet.destroy_all
Scientist.destroy_all
Mission.destroy_all

Faker::TvShows::StarTrek.unique.clear
Faker::Space.unique.clear
Faker::TvShows::Buffy.unique.clear

fields = ["Pluto Specialist", "Earth Specialist", "Trillian Specialist", "Saturn Specialist"]

length = [64, 2, 45, 22, 36, 45, 57, 59, 534, 422, 23, 876, 434, 642, 543, 4567,2, 5, 66, 34, 2, 5, 7]

puts "Making planets..."
20.times {Planet.create(name: Faker::TvShows::StarTrek.unique.location,
                        distance_from_earth: Faker::Space.unique.distance_measurement,
                        nearest_star: Faker::Space.star,
                        image: "planet#{rand(1..10)}")}

puts "Making scientists..."                        
15.times {Scientist.create(name: Faker::FunnyName.name,
                           field_of_study: fields.sample,
                           avatar: Faker::Avatar.image(size: "200x200", set: "set3"))}

puts "Making missions..."                           
20.times {Mission.create(name: Faker::TvShows::Buffy.unique.episode,
                         scientist: Scientist.all.sample, 
                         planet: Planet.all.sample,
                         length_in_days: length.sample)}

puts "Done seeding!"                         