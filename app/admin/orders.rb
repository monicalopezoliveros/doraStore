ActiveAdmin.register Order do
  permit_params :customer_id, :order_date, :status, :notes,
                order_details_attributes: [:id, :product_id, :quantity, :unit_price, :_destroy]

  # Override the update action
  controller do
    def update
      # Actualizar la orden y sus detalles
      if resource.update(permitted_params[:order])
        redirect_to resource_path, notice: "Order updated successfully!"
      else
        render :edit, alert: "There was an issue updating the order."
      end
    end
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :customer_id,
              as: :select,
              collection: Customer.all.map { |c| ["#{c.full_name} - #{c.email}", c.id] },
              include_blank: false
      f.input :order_date, as: :datepicker
      f.input :status, as: :select, collection: Order.statuses.keys
    end

    # Nested form for order details
    f.inputs "Order Items" do
      f.has_many :order_details, allow_destroy: true, new_record: true do |od|
        od.input :product, collection: Product.all.map { |p| [p.name, p.id] }, include_blank: false, input_html: { id: "product_#{od.index}" }
        od.input :quantity
        od.input :unit_price, input_html: { id: "price_#{od.object.id}"}


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
    column :status do |order|
       order.status ? order.status.capitalize : "Unknown"
    end
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
      row :status do |order|
        order.status.capitalize
      end
      row :notes
    end

    panel "Order Details" do
      table_for order.order_details do
        column "Product" do |detail|
          detail.product.name
        end
        column :quantity
        column "Unit Price" do |detail|
          "$#{'%.2f' % detail.unit_price}"
        end
        column "Total" do |detail|
          "$#{'%.2f' % (detail.quantity * detail.unit_price)}"
        end
      end
    end
  end
end
