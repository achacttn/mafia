# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

u1 = User.create name: "Alex", password: "chicken", alive: true, mafia: true
u2 = User.create name: "Bob", password: "chicken", alive: true, mafia: false
u3 = User.create name: "Carol", password: "chicken", alive: true, mafia: false

puts "Created #{User.all.length} users."


Room.destroy_all
r1 = Room.create name: 'Oceania', playerCount: 2
r2 = Room.create name: 'WigglesTown', playerCount: 3
r3 = Room.create name: 'Amazon', playerCount: 3
r4 = Room.create name: 'Something', playerCount: 1
r5 = Room.create name: 'AnotherPlace', playerCount: 2
r6 = Room.create name: 'ThisPlace', playerCount: 3

puts "Created #{ Room.all.length} rooms."
