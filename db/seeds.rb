# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "ffaker"

USERS_COUNT = 5

users = (1..USERS_COUNT).each.map do |i|
  email = "user_#{i}@gmail.com"
  User.create!(
    email: email,
    password: "Password123!"
  )
end

authors = 10.times.map do
  Author.create!(
    user: users.sample,
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
  )
end

10.times do
  Book.create!(
    user: users.sample,
    title: FFaker::Book.title,
    author: authors.sample
  )
end
