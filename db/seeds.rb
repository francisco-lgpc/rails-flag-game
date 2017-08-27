# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

puts "Destroying countries..."

Country.destroy_all


puts "Creating a default user..."

User.create!(email: "test@email.com", password: "password")


puts "Creating countries..."

countries_url = "https://restcountries.eu/rest/v2/all"
countries_serialized = open(countries_url).read
countries = JSON.parse(countries_serialized)

countries.each do |country|


  Country.create!(
      name: country["name"],
      code: country["alpha2Code"],
      flag: country["flag"]
    )
end

puts "Done!"

