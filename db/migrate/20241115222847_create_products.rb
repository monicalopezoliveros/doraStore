class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :category_id
      t.integer :stock
      t.integer :status_flag

      t.timestamps
    end
  end
end
