class CustomersController < ApplicationController
  # Action to display the registration form
  def new
    @customer = Customer.new
  end

  # Action to handle the creation of a new client
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      # Here you can redirect to a success page or login
      redirect_to root_path, notice: 'Cuenta creada exitosamente.'
    else
      # If not saved correctly, the form is displayed again with errors
      render :new
    end
  end

  private

  # Strong parameters to ensure that only allowed fields are sent
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :address, :postal_code, :city, :province_id, :password, :password_confirmation)
  end
end
