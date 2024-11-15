ActiveAdmin.register Product do

  permit_params :name, :price, :category_id, :stock, :status_flag, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :category_id
      f.input :stock
      f.input :status_flag
      f.input :image, as: :file
    end
    f.actions
  end


end

