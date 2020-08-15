FactoryBot.define do
  factory :recipe do
    user
    sequence(:title) { |n| "Delicious Pizza#{n}" }
    description { "Lets make a pizza"}

    # instructions_attributes { [
    #   { direction: "Stir for 20 min" },
    #   { direction: "Stir for 20 min" },
    #   { direction: "Stir for 20 min" },
    #   { direction: "Stir for 20 min" },
    #   { direction: "Stir for 20 min" }
    # ] }

    # ingridients_attributes { [
    #   { content: "Eggs" },
    #   { content: "Milk" },
    #   { content: "Honey" },
    #   { content: "Salt" },
    #   { content: "Bread" }
    # ] }
  end
end