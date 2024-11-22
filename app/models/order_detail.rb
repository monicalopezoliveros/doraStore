class OrderDetail < ApplicationRecord
  # Associations
  belongs_to :order
  belongs_to :product

  # Validations
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  before_validation :set_unit_price, if: -> { product_id.present? && unit_price.blank? }

  private

   # Method
  def set_unit_price
    self.unit_price = product.price
  end
end
