require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Welcome Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    visit root_path
  end

  it 'displays the welcome message' do
    expect(page).to have_content('Welcome:')
    expect(page).to have_content('Budget App')
  end

  context 'when user is signed in' do
    before(:each) do
      @user = User.create(name: 'isongkel', email: 'isongkel@gmail.com', password: 'isongkel')
      login_as(@user, scope: :user)
      visit root_path
    end
  end

  context 'when user is not signed in' do
    it 'displays Log in and Sign up buttons' do
      expect(page).to have_selector('#login-btn', text: 'Log in')
      expect(page).to have_selector('#signup-btn', text: 'sign_up')
    end

    it 'redirects to new_user_session_path when clicking Log in button' do
      click_on 'Log in'
      expect(page).to have_current_path(new_user_session_path)
    end

    it 'redirects to new_user_registration_path when clicking Sign up button' do
      click_on 'sign_up'
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
