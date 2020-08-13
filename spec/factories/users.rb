FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testing#{n}@test.com" }
    sequence(:handle) { |n|"John#{n}" }
    first_name { 'John' }
    last_name { 'Smith' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
