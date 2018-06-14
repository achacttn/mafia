# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all

u1 = User.create name: "Alex", password: "chicken"
u2 = User.create name: "Bob", password: "chicken"
u3 = User.create name: "Carol", password: "chicken"
u4 = User.create name: "David", password: "chicken"
u5 = User.create name: "Eve", password: "chicken"


Room.destroy_all
r1 = Room.create name: 'Oceania', playerCount: 0, description: "Test"
r2 = Room.create name: 'WigglesTown', playerCount: 0, description: "Test"
r3 = Room.create name: 'Amazon', playerCount: 0, description: "Test"
r4 = Room.create name: 'Something', playerCount: 0, description: "Test"
r5 = Room.create name: 'AnotherPlace', playerCount: 0, description: "Test"
r6 = Room.create name: 'ThisPlace', playerCount: 0, description: "Test"

puts "Created #{ Room.all.length} rooms."

r1.users << u2
r1.users << u3
r2.users << u4
r2.users << u5

puts "Created #{User.all.length} users."
puts 'aaa'
