class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :categories
  has_many :purchases, foreign_key: 'author_id' # Specify the custom foreign key for tests

  # Attributes
  attribute :name, :string

  # Validations
  validates :name, presence: true
end
