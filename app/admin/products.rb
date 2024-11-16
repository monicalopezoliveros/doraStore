ActiveAdmin.register Product do

  permit_params :name, :price, :metal, :category_id, :stock, :status_flag, :description, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :metal, as: :select, collection: ["gold", "silver", "bronze", "platinum", "other"], include_blank: false
      f.input :category_id, as: :select, collection: Category.all.collect { |category| [category.name, category.id] }, include_blank: false
      f.input :stock
      f.input :status_flag, as: :select, collection: Product.status_flags.keys.map { |status| [status.humanize, status] }
      f.input :description
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :metal
    column :category
    column :stock
    column :status_flag
    actions
  end
end
