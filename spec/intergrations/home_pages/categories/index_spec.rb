require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Categories Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = create(:user, name: 'Test User', email: 'test@example.com', password: 'password')

    # Create and save Category instances using FactoryBot
    @category1 = create(:category, name: 'Category 1', user: @user)
    @category2 = create(:category, name: 'Category 2', user: @user)

    login_as(@user, scope: :user)
    visit categories_path
  end

  it 'displays the Categories page' do
    expect(page).to have_content('Categories')
  end

  it 'displays the "Add a New Category" button' do
    expect(page).to have_content('Add a New Category')
  end

  it 'displays a list of categories' do
    expect(page).to have_link(@category1.name, href: category_path(@category1))
    expect(page).to have_link(@category2.name, href: category_path(@category2))
  end

  it 'redirects to the root path when clicking the Back button' do
    click_link('Back')
    expect(page).to have_current_path(root_path)
  end

  it 'logs the user out when clicking the Sign Out link' do
    click_link('Sign Out')
    expect(page).to have_current_path(root_path)
  end
end
