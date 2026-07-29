FactoryBot.define do
  factory :list do
    user

    name { FFaker::Lorem.words(rand(2..4)).join(" ").titleize }

    trait :with_books do
      after(:create) do |list|
        create_list(:book, 3, list: list)
      end
    end

    trait :default do
      default { true }
    end
  end
end
