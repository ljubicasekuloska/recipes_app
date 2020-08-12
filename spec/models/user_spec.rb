require 'rails_helper'

 RSpec.describe User do
   context "when saving" do
     it "transforms email to lower case" do
       john = create(:user, email: 'TESTING@TEST.COM')

       expect(john.email).to eq 'testing@test.com'
     end
   end

   describe 'associations' do
     it { is_expected.to have_many(:recipes) }

     describe 'dependency' do
       let(:recipes_count) { 1 }
       let(:user) { create(:user) }

       it 'destroys recipes' do
         create_list(:recipe, recipes_count, user: user)

         expect { user.destroy }.to change { Recipe.count }.by(-recipes_count)
       end
     end
   end

   describe 'validations' do
     it { is_expected.to validate_presence_of(:handle) }
     it { is_expected.to validate_presence_of(:email) }
     it { is_expected.to validate_presence_of(:first_name) }
     it { is_expected.to validate_presence_of(:last_name) }
     it { is_expected.to validate_presence_of(:password) }

     it { is_expected.to have_secure_password }

     context 'when matching uniqueness of email' do
       subject { create(:user) }

       it { is_expected.to validate_uniqueness_of(:email) }
     end

     it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGHT) }
     it { is_expected.to validate_length_of(:handle).is_at_most(User::MAXIMUM_LENGTH) }
     it { is_expected.to validate_length_of(:email).is_at_most(User::MAXIMUM_LENGTH) }
     it { is_expected.to validate_length_of(:first_name).is_at_most(User::MAXIMUM_LENGTH) }
     it { is_expected.to validate_length_of(:last_name).is_at_most(User::MAXIMUM_LENGTH) }

     context 'when using invalid email format' do
       it 'is invalid' do
         john = build(:user, email: 'test@invalid')

         expect(john.valid?).to be false
       end
     end
   end
 end