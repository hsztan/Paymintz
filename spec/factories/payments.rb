FactoryBot.define do
  factory :payment do
    name { Faker::Name.name }
    amount { Faker::Number.number(digits: 2) }
    user
  end
end
