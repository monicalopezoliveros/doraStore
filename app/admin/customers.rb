ActiveAdmin.register Customer do

  permit_params :first_name, :last_name, :email, :phone, :address, :postal_code, :city, :province_id, :gender, :password

  form do |f|
    f.inputs "Customer Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :address
      f.input :postal_code
      f.input :city
      f.input :province_id, as: :select, collection: Province.all.collect { |province| [province.name, province.id] }, include_blank: false
      f.input :gender
      f.input :password
    end
    f.actions
  end


end
# index do
#   selectable_column
#   column :id
#   column :first_name
#   column :last_name
#   column :orders # Esto fallará si no existe la relación o el modelo Order
#   actions
# end