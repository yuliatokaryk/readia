FactoryBot.define do
  factory :book do
    user

    title { FFaker::Book.title }
  end
end
