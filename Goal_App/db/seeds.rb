# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(username: "karen", password: "123456")

30.times do
  User.create(
    username: Faker::Internet.user_name,
    password: Faker::Internet.password
  )
end

true_false = [false, true]

300.times do
  Goal.create(
    body: Faker::Lorem.sentence,
    user_id: rand(1..30),
    completed: rand(2),
    private_status: rand(2)
  )
end
