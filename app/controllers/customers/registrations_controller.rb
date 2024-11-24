class Customers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name, :last_name, :address, :city, :province_id, :postal_code
    ])
  end

  respond_to :html, :turbo_stream

  def respond_with(resource, _opts = {})
    if resource.persisted?
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Account created successfully!' }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
end
