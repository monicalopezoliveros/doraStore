class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :shipping_address_id
      t.datetime :order_date
      t.text :notes

      t.timestamps
    end
  end
end
