require 'rails_helper'

RSpec.describe 'Requirements', type: :system do
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
