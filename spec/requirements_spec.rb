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
    it 'user should not be able to see the groups page if user not logged in' do
      visit groups_path
      expect(page).to_not have_selector('.groups')
    end
  end
end

RSpec.describe 'Requirements with user logged in', type: :system do
  context 'sign up and log in pages' do
    it 'user should be able to register and login into the app using email and password' do
      visit new_user_registration_path
      name = Faker::Name.name
      email = Faker::Internet.email
      password = Faker::Internet.password
      @test_user = build(:user, name:, email:, password:, password_confirmation: password)
      @test_user.skip_confirmation!
      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      fill_in 'user_password_confirmation', with: password
      form_submit = find('input[type="submit"]')
      @test_user.skip_confirmation!
      form_submit.click
      @test_user.save
      visit user_session_path
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      form_submit = find('input[type="submit"]')
      form_submit.click
      expect(page).to have_content('CATEGORIES')
    end
  end
end

RSpec.describe 'Requirements with with user logged in', type: :system do
  context 'home page (groups page)' do
    before do
      User.destroy_all
      @user = build(:user)
      @user.skip_confirmation!
      @user.save!
      sign_in @user
      @group = create(:group, user: @user)
      @payment = create(:payment, user: @user)
      @group.payments << @payment
    end
    it 'when user is logged in, it should display the groups page' do
      visit groups_path
      expect(page).to have_selector('.groups')
    end
    it 'for each category, the user can see the name, icon, and total amount of all transactions' do
      visit groups_path
      expect(page).to have_content(@group.name)
      expect(page).to have_content(@group.transactions_total)
      expect(page).to have_css("img[src=\"#{@group.icon}\"]")
    end
    it 'the user can click on the name of a category to see all transactions for that category' do
      visit groups_path
      click_link @group.name
      expect(page).to have_content(@payment.name)
      expect(page).to have_content(@payment.amount)
    end
    it 'navigate to the new group page' do
      visit groups_path
      click_link 'New Category'
      expect(page).to have_content('NEW CATEGORY')
    end
  end
end
