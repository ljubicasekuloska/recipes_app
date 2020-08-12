FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "testing#{n}@test.com" }
    handle { 'John' }
    first_name { 'John' }
    last_name { 'Smith' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
