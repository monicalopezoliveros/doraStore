class Product < ApplicationRecord
  has_one_attached :image

  belongs_to :category

  enum status_flag: { On_sale: 0, New: 1, Recently_updated: 2 }
end
