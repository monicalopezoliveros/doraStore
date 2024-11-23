class CartsController < ApplicationController
  # Mostrar el contenido del carrito
  def show
    @cart = session[:cart] || []
  end

  # Agregar productos al carrito
  def add_to_cart
    product = Product.find(params[:product_id])

    # Inicializar el carrito si está vacío
    session[:cart] ||= []
    cart = session[:cart]

    # Verificar si el producto ya está en el carrito
    item = cart.find { |i| i["product_id"] == product.id }
    if item
      # Incrementar cantidad si ya existe
      item["quantity"] += params[:quantity].to_i
    else
      # Agregar nuevo producto
      cart << {
        "product_id" => product.id,
        "name" => product.name,
        "price" => product.price.to_f,
        "quantity" => params[:quantity].to_i
      }
    end

    flash[:notice] = "#{product.name} agregado al carrito."
    redirect_to cart_path
  end

  # Actualizar cantidad de un producto en el carrito
  def update_quantity
    cart = session[:cart]
    item = cart.find { |i| i["product_id"] == params[:product_id].to_i }

    if item
      item["quantity"] = params[:quantity].to_i
      flash[:notice] = "Cantidad actualizada."
    else
      flash[:alert] = "Producto no encontrado en el carrito."
    end

    redirect_to cart_path
  end

  # Eliminar producto del carrito
  def remove_item
    cart = session[:cart]
    cart.reject! { |i| i["product_id"] == params[:product_id].to_i }

    flash[:notice] = "Producto eliminado del carrito."
    redirect_to cart_path
  end

  def checkout_form
    @cart = current_cart
  end

  private

  # Método para obtener el carrito actual
  def current_cart
    session[:cart] || []
  end
end
