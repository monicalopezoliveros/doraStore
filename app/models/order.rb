class Order < ApplicationRecord
  belongs_to :customer

  def customer_address
    customer.address
  end
end
