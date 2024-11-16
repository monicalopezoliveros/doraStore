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
    f.actions
  end
end
