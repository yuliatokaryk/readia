FactoryBot.define do
  factory :author do
    user

    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
  end
end
