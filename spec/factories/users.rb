FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { "password123" }
  end
end
