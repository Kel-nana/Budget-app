# spec/factories/categories.rb

FactoryBot.define do
  factory :category do
    name { 'Category 1' }
    icon { 'login-icon.png' }
    user
  end
end
