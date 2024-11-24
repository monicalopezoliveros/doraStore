class AddDeviseToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :encrypted_password, :string
    add_column :customers, :reset_password_token, :string
    add_column :customers, :reset_password_sent_at, :datetime
    add_column :customers, :remember_created_at, :datetime

    add_index :customers, :reset_password_token, unique: true
  end
end
