FactoryBot.define do
  factory :user do
    name 'Fabricio'
    sequence(:email) { |n| "user_#{n}@example.com" }
    password "12345678"
  end
end
