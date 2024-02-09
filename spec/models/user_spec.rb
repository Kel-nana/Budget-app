# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Devise configuration' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }
    it { should allow_value('user@example.com').for(:email) }
  end

  describe 'associations' do
    it { should have_many(:categories) }
    it { should have_many(:purchases) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
