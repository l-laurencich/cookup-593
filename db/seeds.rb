# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Event.destroy_all
User.destroy_all

hosts = []
10.times do
  user = User.new ({email: Faker::Internet.email, password: "1245677", first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, date_of_birth: Faker::Date.between(from: '1980-09-23', to: '1996-09-25'), interests: Faker::Book.genre})
  user.save
  hosts << user
end

10.times do
  locations = ['Berger Straße 275, Frankfurt', 'Georg-Voigt-Str. 20, Frankfurt', 'Schweizer Straße 10, Frankfurt']
  event = Event.new ({location: locations.sample, start: Faker::Time.forward(days: 25,  period: :evening, format: :long), end: Faker::Time.forward(days: 5,  period: :evening, format: :long), name: Faker::FunnyName.name, description: Faker::Food.description, dietary_requirements: Faker::Food.dish, menu: Faker::Food.dish, price: rand(0.0..10.0).round(1), capacity: rand(2..8), user: hosts.sample})
  event.save
end


puts "10 events & 10 users created"


# owned_events:Event.all.sample
