require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Category Show Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    # Create a user for testing
    @user = create(:user, name: 'Test User', email: 'test1@example.com', password: 'password')

    # Create a category for testing
    @category = create(:category, name: 'Category 1', user: @user)

    # Simulate user login
    login_as(@user, scope: :user)
  end
  it 'displays category details and purchases' do
    visit category_path(@category)

    expect(page).to have_content('Category 1', wait: 10)
    expect(page).to have_content('Total: $0.0', wait: 10)
    expect(page).to have_content('Edit category', wait: 10)
  end

  it 'navigates to new purchases' do
    visit category_path(@category)

    click_link('New purchase')
    expect(page).to have_current_path(new_category_purchase_path(@category))
  end

  it 'navigates to Edit category' do
    visit category_path(@category)

    click_link('Edit category')
    expect(page).to have_current_path(edit_category_path(@category))
  end

  it 'navigates to previous page' do
    visit category_path(@category)

    click_link('Back')
    expect(page).to have_current_path(categories_path)
  end

  it 'logs the user out when clicking the Sign Out link' do
    visit category_path(@category)

    click_link('Sign Out')

    # Expect the user to be redirected to the sign-in page
    expect(page).to have_current_path(root_path)
  end
end
