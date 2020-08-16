FactoryBot.define do
  factory :recipe do
    user
    sequence(:title) { |n| "Delicious Pizza#{n}" }
    description { "Lets make a pizza"}
  end
end