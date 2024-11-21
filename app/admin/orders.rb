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
        # od.input :unit_price, input_html: { id: "price_#{od.index}", readonly: true }  # Aquí puedes activar el precio si lo necesitas
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
    column "Total Amount" do |order|
      number_to_currency(order.total_amount) # Display total as currency
    end
    column "Total with Tax" do |order|
      number_to_currency(order.total_with_tax) # Display total with tax as currency
    end
    column "Province and Tax" do |order|
      province = order.customer.province
      "Province: #{province.name}, Tax: #{'%.2f' % province.tax}" # Display province name and tax rate
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

    # Displays the total of the order
    panel "Order Total" do
      div do
        strong "Total Amount: "
        span number_to_currency(order.total_amount) # Mostrar el total como moneda
      end
      div do
        strong "Total with Tax: "
        span number_to_currency(order.total_with_tax) # Mostrar el total con impuestos
      end
    end
    # Note with Province and Tax information
    panel "Province and Tax Info" do
      province = order.customer.province
      div do
        strong "Province: "
        span province.name
      end
      div do
        strong "Tax Rate: "
        span "#{'%.2f' % province.tax}%"
      end
    end
  end
end
