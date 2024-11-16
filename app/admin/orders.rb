ActiveAdmin.register Order do

  permit_params :customer_id, :shipping_address_id, :order_date, :notes

  form do |f|
    f.inputs do
      f.input :customer_id
      # f.input :shipping_address_id
      # f.input :category_id, as: :select, collection: Category.all.collect { |category| [category.name, category.id] }, include_blank: false
      f.input :order_date
      f.input :notes
    end
    f.actions
  end
end
