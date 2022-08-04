require 'rails_helper'

RSpec.describe 'Requirements with without user logged in', type: :system do
  context 'splash page' do
    it 'should diplay a splash page if user not logged in' do
      visit groups_path
      expect(page).to have_selector('.splash')
    end
    it 'should display a link to the login page if user not logged in' do
      visit groups_path
      expect(page).to have_link('LOG IN')
    end
    it 'should display a link to the sign up page if user not logged in' do
      visit groups_path
      expect(page).to have_link('SIGN UP')
    end
  end
end

# Rspec.describe 'Requirements with user logged in', type: :system do
#   context 'sign up and log in pages' do
#     it 'user should be able to register in the app with full name, email and password' do
#       visit new_user_registration_path
#       fill_in 'Name', with: 'John Doe'
#       fill_in 'Email', with: 'jdoe@gmail.com'
#       fill_in 'Password', with: 'password'
#       fill_in 'Password confirmation', with: 'password'
#       click_button 'Sign up'
#     end
#   end
# end

RSpec.describe 'Requirements with with user logged in', type: :system do
  context 'home page (groups page)' do
    before do
      User.destroy_all
      @user2 = create(:user)
      @user = User.new(name: 'John Doe', email: 'jdoe@gmail.com', password: 'password',
                       password_confirmation: 'password')
      @user.confirmed_at = Time.now
      @user.skip_confirmation!
      @user.save!
      sign_in @user
    end
    it 'when user is logged in, it should display the groups page' do
      visit groups_path
      expect(page).to have_selector('.groups')
    end
  end
end
