ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  form do |f|
    f.inputs 'Page Details' do
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end

  # Setting to display columns in list view
  index do
    selectable_column
    id_column
    column :title
    actions
  end
end
