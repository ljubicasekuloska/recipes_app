require 'rails_helper'

RSpec.describe "HomePages" do
  before do
    driven_by :rack_test

    visit root_path
  end

  it 'shows the home link' do
    expecting = page.has_link?('Recipes')

    expect(expecting).to be true
  end

  context 'when no user is signed in' do
    it 'shows the Log In link' do
      expecting = page.has_link?('Log In')

      expect(expecting).to be true
    end

    it 'shows the Sign Up link' do
      expecting = page.has_link?('Sign Up')

      expect(expecting).to be true
    end

  end

  context 'when user is signed in' do
    let(:user) { create(:user) }
    let!(:recipe) { create(:recipe, title: 'Testing with RSpec', description: 'Testing recipe description', user: user) }
    before do
      system_log_in(user)
      visit root_path
    end

    it 'shows the New Recipe link' do
      expecting = page.has_link?('New Recipe')

      expect(expecting).to be true
    end

    it 'shows the Log Out link' do
      expecting = page.has_link?('Log Out')

      expect(expecting).to be true
    end

    it 'shows the link to recipe' do
      expecting = page.has_link?('Show')

      expect(expecting).to be true
    end

    it 'shows the link to edit the recipe' do
      expecting = page.has_link?('Edit')

      expect(expecting).to be true
    end

    it 'shows the link to delete the recipe' do
      expecting = page.has_link?('Delete')

      expect(expecting).to be true
    end
  end
    context 'when diferent user is signed in' do
      let(:user) { create(:user) }
      let!(:recipe) { create(:recipe, title: 'Testing with RSpec', description: 'Testing recipe description', user: user) }
      before do
        system_log_in(create(:user))
        visit root_path
      end

      it 'shows the link to recipe' do
        expecting = page.has_link?('Show')

        expect(expecting).to be true
      end

      it "doesn't show the link to edit the recipe" do
        expecting = page.has_link?('Edit')

        expect(expecting).to be false
      end

      it "doesn't show the link to delete the recipe" do
        expecting = page.has_link?('Delete')

        expect(expecting).to be false
      end
  end

  context 'when a recipe is present' do
    let!(:recipe) { create(:recipe, title: 'Testing with RSpec', description: 'Testing recipe description') }

    before do
      visit root_path
    end

    it 'shows the recipe title' do
      expecting = page.has_content?(recipe.title)

      expect(expecting).to be true
    end

    it 'shows the recipe description' do
      expecting = page.has_content?(recipe.description)

      expect(expecting).to be true
    end

    it 'shows the recipe user handle' do
      expecting = page.has_content?(recipe.user.handle)

      expect(expecting).to be true
    end
  end
end