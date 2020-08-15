FactoryBot.define do
  factory :instruction do
    recipe
    sequence(:direction) { |n| "Bake for #{n} minutes" }
  end
end