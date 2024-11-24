ActiveAdmin.register Province do

  permit_params :name, :tax, :gst, :pst, :hst

  form do |f|
    f.inputs do
      f.input :name
      f.input :gst, as: :number
      f.input :pst, as: :number
      f.input :hst, as: :number
    end
    f.actions
  end

end
