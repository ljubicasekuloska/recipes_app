FactoryBot.define do
  factory :recipe do
    user

    title { 'Delicious Pizza' }
    description { "Lets make a pizza"}
  end
end