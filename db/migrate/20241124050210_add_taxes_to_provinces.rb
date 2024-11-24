class AddTaxesToProvinces < ActiveRecord::Migration[7.0]
  def change
    add_column :provinces, :gst, :decimal, precision: 5, scale: 2
    add_column :provinces, :pst, :decimal, precision: 5, scale: 2
    add_column :provinces, :hst, :decimal, precision: 5, scale: 2
  end
end
