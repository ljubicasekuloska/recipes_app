# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

User.destroy_all

2.times do
  FactoryBot.create :user
end

User.all.each do |user|
  2.times do
    FactoryBot.create(:recipe, user: user)
  end
end

Recipe.all.each do |recipe|
  5.times do
    FactoryBot.create(:ingridient, recipe: recipe)
    FactoryBot.create(:instruction, recipe: recipe)
  end
end