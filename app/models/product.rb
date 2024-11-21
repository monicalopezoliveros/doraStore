class Product < ApplicationRecord
  has_one_attached :image

  belongs_to :category
  has_many :order_details
  has_many :orders, through: :order_details

  enum status_flag: { On_sale: 0, New: 1, Recently_updated: 2 }

  validates :metal, presence: true, inclusion: { in: ["GOLD", "SILVER", "PLATINUM"] }
end
