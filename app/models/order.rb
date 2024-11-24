class Order < ApplicationRecord
  # Associations
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  accepts_nested_attributes_for :order_details, allow_destroy: true

  enum status: {
    pending: 0,
    paid: 1,
    in_progress: 2,
    shipped: 3,
    delivered: 4,
    cancelled: 5,
    refunded: 6,
    failed: 7
  }

  # Validations
  validates :status, presence: true, inclusion: { in: statuses.keys }

  def customer_address
    customer.address
  end

  # Method for calculating the order total
  def total_amount
    order_details.sum { |detail| detail.quantity.to_i * detail.unit_price.to_f }
  end

  # Method for calculating the total with taxes according to the client's province
  def total_with_tax
    subtotal = total_amount
    taxes = customer.calculate_taxes(subtotal)  # The method is called from the Client
  end

end
