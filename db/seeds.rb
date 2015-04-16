# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

zoo_stops = [
  ["Darling Harbours", "33.8723", "151.1990", 1],
  ["QVB", "33.8718", "151.2067", 1],
  ["Bondi", "33.8910", "151.2777", 1]
]

admin = {
  email: "admin@perpherior.com",
  password: "123123123"
}

Admin.create email: admin[:email], password: admin[:password]

zoo_stops.each do |name, lati, long, admin|
  ZooStop.create name: name, latitude: lati, longitude: long, admin_id: admin
end