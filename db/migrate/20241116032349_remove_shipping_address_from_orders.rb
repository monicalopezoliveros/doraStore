class RemoveShippingAddressFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :shipping_address_id, :integer
  end
end
