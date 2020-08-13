FactoryBot.define do
  factory :recipe do
    sequence(:title) { |n| "Delicious Pizza#{n}" }
    #title { 'Delicious Pizza' }
    description { "Lets make a pizza"}

    instructions_attributes { [
      { direction: "Stir for 20 min" },
      { direction: "Stir for 20 min" },
      { direction: "Stir for 20 min" },
      { direction: "Stir for 20 min" },
      { direction: "Stir for 20 min" }
    ] }

    ingridients_attributes { [
      { content: "Egs" },
      { content: "Egs" },
      { content: "Egs" },
      { content: "Egs" },
      { content: "Egs" }
    ] }
  end
end