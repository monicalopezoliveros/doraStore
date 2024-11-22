class Category < ApplicationRecord
  # Associations
  has_many :products

  # Validations
  validates :name, presence: true, uniqueness: true

end
