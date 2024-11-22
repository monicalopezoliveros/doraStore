ActiveAdmin.register Page do
  permit_params :title, :content, :slug

  # Opcional: personalizar el formulario en el admin
  form do |f|
    f.inputs 'Page Details' do
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end

  # Configuración para mostrar las columnas en la vista de lista
  index do
    selectable_column
    id_column
    column :title
    actions
  end
end
