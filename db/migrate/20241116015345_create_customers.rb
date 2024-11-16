class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :postal_code
      t.string :city
      t.integer :province_id
      t.string :gender
      t.string :password

      t.timestamps
    end
  end
end
