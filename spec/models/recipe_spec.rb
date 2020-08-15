require 'rails_helper'

 RSpec.describe Recipe do
   describe 'associations' do
     it { is_expected.to have_many(:ingridients).dependent(:destroy) }
     it { is_expected.to have_many(:instructions).dependent(:destroy)  }
     it { is_expected.to belong_to(:user) }
     it { is_expected.to accept_nested_attributes_for(:ingridients).allow_destroy(true) }
     it { is_expected.to accept_nested_attributes_for(:instructions).allow_destroy(true) }
     end

   describe 'validations' do
     it { is_expected.to validate_presence_of(:title) }
     it { is_expected.to validate_presence_of(:description) }
   end
 end