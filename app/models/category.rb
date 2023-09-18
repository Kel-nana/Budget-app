class Category < ApplicationRecord
    # Associations
    belongs_to :user
    has_and_belongs_to_many :purchases
  
    # Validations
    validates :name, presence: true
    validates :icon, presence: true

  end