require 'rails_helper'

RSpec.describe "RecipesInteraction" do
  let(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }
  # let!(:instruction) { create(:instruction, recipe: recipe) }
  # let!(:ingridient) { create(:ingridient, recipe: recipe) }

  before do
    driven_by :rack_test

    system_log_in(user)
  end

  describe 'Creating an recipe' do
    it 'creates and shows the newly created recipe' do
      title = 'Create new system spec'
      description = 'This is the description'
      content = "This is the Ingridient"
      direction = "This is the Instruction"

      click_on('New Recipe')

      within('form') do
        fill_in "Title", with: title
        fill_in "Description", with: description

        fill_in "recipe_ingridients_attributes_0_content", with: content
        fill_in "recipe_ingridients_attributes_1_content", with: content
        fill_in "recipe_ingridients_attributes_2_content", with: content
        fill_in "recipe_ingridients_attributes_3_content", with: content
        fill_in "recipe_ingridients_attributes_4_content", with: content

        fill_in "recipe_instructions_attributes_0_direction", with: direction
        fill_in "recipe_instructions_attributes_1_direction", with: direction
        fill_in "recipe_instructions_attributes_2_direction", with: direction
        fill_in "recipe_instructions_attributes_3_direction", with: direction
        fill_in "recipe_instructions_attributes_4_direction", with: direction

      end
        click_on 'Save Recipe'

      expect(page).to have_content(title)
      expect(page).to have_content(description)
      expect(page).to have_content(content)
      expect(page).to have_content(direction)
    end
  end

  describe 'Editing a recipe' do
    it 'edits and shows the recipe' do
      title = 'New Title'
      description = 'New Description'
      content = "This is the New Ingridient"
      direction = "This is the New Instruction"

      visit recipe_path(recipe)

      click_on 'Edit'

      within('form') do
        fill_in "Title", with: title
        fill_in "Description", with: description

        fill_in "recipe_ingridients_attributes_0_content", with: content
        fill_in "recipe_ingridients_attributes_1_content", with: content
        fill_in "recipe_ingridients_attributes_2_content", with: content
        fill_in "recipe_ingridients_attributes_3_content", with: content
        fill_in "recipe_ingridients_attributes_4_content", with: content

        fill_in "recipe_instructions_attributes_0_direction", with: direction
        fill_in "recipe_instructions_attributes_1_direction", with: direction
        fill_in "recipe_instructions_attributes_2_direction", with: direction
        fill_in "recipe_instructions_attributes_3_direction", with: direction
        fill_in "recipe_instructions_attributes_4_direction", with: direction

        click_on 'Edit Recipe'
      end

      expect(page).to have_content(title)
      expect(page).to have_content(description)
      expect(page).to have_content(content)
      expect(page).to have_content(direction)
    end
  end

  describe 'Deleting a recipe' do
    it 'deletes the recipe and redirect to index view' do

      click_on 'Delete'

      expect(page).to have_content('Recipes')
    end
  end

  describe 'Going back to recipe index page' do
    it 'goes back to recipe index page' do
      visit recipe_path(recipe)

      click_on 'Back'

      expect(page).to have_content('Recipes')
    end
  end

  describe 'Going to author profile page' do
    it 'goes to author profile page form index page' do
      visit root_path
      my_link = find(:xpath, "//a[contains(@href,'/users/')]")
      my_link.click

      expect(page).to have_content('User recipes:')
    end

    it 'goes to author profile page form recipe page' do
      visit recipe_path(recipe)

      my_link = find(:xpath, "//a[contains(@href,'/users/')]")
      my_link.click

      expect(page).to have_content('User recipes:')
    end

  end
end