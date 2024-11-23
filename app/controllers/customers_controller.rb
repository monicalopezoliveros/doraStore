class CustomersController < ApplicationController
  # Acción para mostrar el formulario de registro
  def new
    @customer = Customer.new
  end

  # Acción para manejar la creación de un nuevo cliente
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      # Aquí puedes redirigir a una página de éxito o al inicio de sesión
      redirect_to root_path, notice: 'Cuenta creada exitosamente.'
    else
      # Si no se guarda correctamente, se muestra el formulario nuevamente con errores
      render :new
    end
  end

  private

  # Fuerte parámetros para garantizar que solo los campos permitidos sean enviados
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :address, :postal_code, :city, :province_id, :password, :password_confirmation)
  end
end
