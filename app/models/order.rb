class Order < ApplicationRecord
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

  validates :status, presence: true, inclusion: { in: statuses.keys }

  def customer_address
    customer.address
  end
end
