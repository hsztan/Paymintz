FactoryBot.define do
  factory :user do
    name { 'Henry' }
    email { 'test@test.com' }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now }
  end
end
