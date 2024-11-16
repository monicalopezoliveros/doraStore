class AddMetalToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :metal, :string
  end
end
