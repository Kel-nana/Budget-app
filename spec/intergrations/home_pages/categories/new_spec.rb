require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'New category Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    # Create a user for testing
    @user = create(:user, name: 'Test User', email: 'test1@example.com', password: 'password')

    # Create a category for testing
    @category = create(:category, name: 'Category 1', user: @user)

    # Simulate user login
    login_as(@user, scope: :user)
  end

  it 'displays the navigation section' do
    visit new_category_path

    # Check if the 'Back' link is present
    click_link('Back')
    expect(page).to have_current_path(categories_path)

    # Check if the 'Editing category' heading is present
    expect(page).to have_content('New Category', wait: 10)

    # You can add more expectations as needed for other elements within this section
  end
end
