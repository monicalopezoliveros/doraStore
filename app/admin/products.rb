ActiveAdmin.register Product do

  permit_params :name, :price, :category_id, :stock, :status_flag, :description, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :category_id, as: :select, collection: Category.all.collect { |category| [category.name, category.id] }, include_blank: false
      f.input :stock
      f.input :status_flag, as: :select, collection: Product.status_flags.keys.map { |status| [status.humanize, status] }
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end

end
