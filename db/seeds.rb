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
require "factory_bot_rails"

USERS_COUNT = 5
PASSWORD = "Password123!"
MAX_AUTHOR_COUNT = 50
MAX_BOOK_COUNT = 50

(1..USERS_COUNT).each.map do |i|
  email = "user_#{i}@gmail.com"
  user = User.find_or_initialize_by(
    email: email
  )
  next if user.persisted?

  user.password = PASSWORD
  user.save!
end

if Author.count < MAX_AUTHOR_COUNT
  10.times.map do
    FactoryBot.create(
      :author,
      :with_last_name,
      user: User.all.sample
    )
  end
end

if Book.count < MAX_BOOK_COUNT
  10.times do
    FactoryBot.create(
      :book,
      user: User.all.sample,
      author: Author.all.sample
    )
  end
end
