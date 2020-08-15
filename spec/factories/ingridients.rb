FactoryBot.define do
  factory :ingridient do
    recipe
    sequence(:content) { |n| "Cheese#{n}" }
  end
end