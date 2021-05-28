# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require "open-uri"

Event.destroy_all
User.destroy_all

hosts = []
  file = URI.open ('https://images-na.ssl-images-amazon.com/images/I/81rhSecMGyL._AC_SX522_.jpg')
  peter = User.new ({email: 'peter@griffin.com', password: "lewagon", first_name: 'Peter', last_name: 'Griffin', date_of_birth: '1978-05-20', interests: ' America, Football, Bacon'})
  peter.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  peter.save
  hosts << peter

  event = Event.new ({location: 'Balanstraße 73 München', start: ' Sat, 29 May 2021 19:00:00 UTC +00:00', name: 'PizzaParty with the Griffins', description: 'Come over to our House this Friday and enjoy delicous Pizza, homemade after our Family recipe', dietary_requirements: 'vegetarian friendly options', menu: 'Homemade Pizzas with different toppings', price: 7.50, capacity: 4, user: peter})
  file = URI.open("http://loremflickr.com/300/300/#{event.menu.gsub(' ','&')}")
  event.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  event.save

10.times do
  file = URI.open('https://images.unsplash.com/photo-1493666438817-866a91353ca9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1949&q=80')
  user = User.new ({email: Faker::Internet.email, password: "1245677", first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, date_of_birth: Faker::Date.between(from: '1980-09-23', to: '1996-09-25'), interests: Faker::Book.genre})
  user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  user.save
  hosts << user
end

10.times do
  locations = ['Berger Straße 275, Frankfurt', 'Georg-Voigt-Str. 20, Frankfurt', 'Schweizer Straße 10, Frankfurt']
  dietary_requirements = ['vegan', 'vegetarian', 'halal', 'kosher', 'lactose free', 'gluten-free']
  event = Event.new ({location: locations.sample, start: Faker::Time.forward(days: 25,  period: :evening, format: :long), end: Faker::Time.forward(days: 5,  period: :evening, format: :long), name: Faker::FunnyName.name, description: Faker::Food.description, dietary_requirements: dietary_requirements.sample, menu: Faker::Food.dish, price: rand(0.0..10.0).round(1), capacity: rand(2..8), user: hosts.sample})
  file = URI.open("http://loremflickr.com/300/300/#{event.menu.gsub(' ','')}")
  event.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  event.save
end


puts "11 events & 11 users created"


# owned_events:Event.all.sample
