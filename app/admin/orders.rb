ActiveAdmin.register Order do

  permit_params :customer_id, :order_date, :notes

  form do |f|
    f.inputs "Order Details" do
      # Select the client associated with the order
      f.input :customer_id,
              as: :select,
              collection: Customer.all.map { |c| ["#{c.full_name} - #{c.email}", c.id] },
              include_blank: false

      f.input :order_date, as: :datepicker
      f.input :notes
    end

    # Nested form for order details
    f.inputs "Order Items" do
      f.has_many :order_details, allow_destroy: true, new_record: true do |od|
        od.input :product, collection: Product.all.map { |p| [p.name, p.id] }
        od.input :quantity
        od.input :unit_price
      end
    end
    f.actions
  end

  # Set the index view
  index do
    selectable_column
    id_column
    column :customer
    column :order_date
    column :notes
    column "Order Details" do |order|
      order.order_details.map do |detail|
        "Product: #{detail.product.name}, Quantity: #{detail.quantity}, Unit Price: #{detail.unit_price}"
      end.join("<br>").html_safe
    end
    actions
  end

  # Set the detail view (show)
  show do
    attributes_table do
      row :customer
      row :order_date
      row :notes
    end

    panel "Order Details" do
      table_for order.order_details do
        column :product
        column :quantity
        column :unit_price
      end
    end
  end
end
