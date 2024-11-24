class CartsController < ApplicationController
  # Show cart contents
  def show
    @cart = session[:cart] || []
  end

  # Add products to cart
  def add_to_cart
    product = Product.find(params[:product_id])

    # Reset cart if empty
    session[:cart] ||= []
    cart = session[:cart]

    # Check if the product is already in the cart
    item = cart.find { |i| i["product_id"] == product.id }
    if item
      # Increase quantity if it already exists
      item["quantity"] += params[:quantity].to_i
    else
      # Add new product
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

  # Update quantity of a product in the cart
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

  # Remove product from cart
  def remove_item
    cart = session[:cart]
    cart.reject! { |i| i["product_id"] == params[:product_id].to_i }

    flash[:notice] = "Producto eliminado del carrito."
    redirect_to cart_path
  end

  def checkout_form
    @cart = current_cart

    subtotal = @cart.sum { |item| item["price"].to_f * item["quantity"].to_i }

    if current_customer
      taxes = current_customer.calculate_taxes(subtotal)
    else
      taxes = 0
    end

    @subtotal = subtotal
    @taxes = taxes
    @total = subtotal + taxes
  end

  private

  # Method to get the current cart
  def current_cart
    session[:cart] || []
  end
end
