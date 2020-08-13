require 'rails_helper'

 RSpec.describe Recipe do
   describe 'associations' do
     it { is_expected.to have_many(:ingridients) }
     it { is_expected.to have_many(:instructions) }
     it { is_expected.to belong_to(:user) }
     it { is_expected.to accept_nested_attributes_for(:ingridients).allow_destroy(true) }
     it { is_expected.to accept_nested_attributes_for(:instructions).allow_destroy(true) }


     describe 'dependency' do
       let(:ingridients_count) { 0 }
       let(:instructions_count) { 0 }
       let(:user) { create(:user) }
       let(:recipe) { create(:recipe, user: user) }

       it 'destroys ingridients' do
         create_list(:ingridient, ingridients_count, recipe: recipe)

         expect { recipe.destroy }.to change { Ingridient.count }.by(-5)
       end

       it 'destroys instructions' do
        create_list(:instruction, instructions_count, recipe: recipe)

        expect { recipe.destroy }.to change { Instruction.count }.by(-5)
      end
     end
   end

   describe 'validations' do
     it { is_expected.to validate_presence_of(:title) }
     it { is_expected.to validate_presence_of(:description) }

   end
 end