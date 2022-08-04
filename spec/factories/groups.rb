FactoryBot.define do
  factory :group do
    name { Faker::Name.name }
    icon { 'https://picsum.photos/90' }
    user
  end
end
