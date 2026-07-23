FactoryBot.define do
  factory :book do
    user

    title { FFaker::Book.title }

    trait :with_author do
      author
    end
  end
end
