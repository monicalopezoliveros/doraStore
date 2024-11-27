class CartsController < ApplicationController
  # Show cart contents
  def show
    @cart = session[:cart] || []
  end

  # Add products to cart
  def add_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if quantity <= 0
      flash[:alert] = "Invalid quantity."
      return redirect_to products_path
    end

    # Reset cart if empty
    session[:cart] ||= []
    cart = session[:cart]

    # Check if the product is already in the cart
    item = cart.find { |i| i["product_id"] == product.id }
    if item
      # Increase quantity if it already exists
      item["quantity"] += quantity
    else
      # Add new product
      cart << {
        "product_id" => product.id,
        "name" => product.name,
        "price" => product.price.to_f,
        "quantity" => quantity
      }
    end

    flash[:notice] = "#{product.name} added to cart."
    redirect_to cart_path
  end

  # Update quantity of a product in the cart
  def update_quantity
    cart = session[:cart]
    item = cart.find { |i| i["product_id"] == params[:product_id].to_i }

    if item
      item["quantity"] = params[:quantity].to_i
      flash[:notice] = "Updated quantity."
    else
      flash[:alert] = "Product not found in cart."
    end

    redirect_to cart_path
  end

  # Remove product from cart
  def remove_item
    cart = session[:cart]
    cart.reject! { |i| i["product_id"] == params[:product_id].to_i }

    flash[:notice] = "Product removed from cart."
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

    @address = current_customer.address
    @city = current_customer.city
    @postal_code = current_customer.postal_code
    @province = current_customer.province.name

  end

  # Método para crear la orden
  def create_order
    @cart = current_cart
    @customer = current_customer

    # Verificamos si el cliente está autenticado
    if @customer
      # Crear la orden
      order = @customer.orders.create(status: :pending) # Estado inicial 'pendiente'

      # Crear los detalles de la orden a partir del carrito
      @cart.each do |item|
        product = Product.find(item["product_id"])
        order.order_details.create!(
          product: product,
          quantity: item["quantity"],
          unit_price: item["price"]
        )
      end

      # Limpiar el carrito después de crear la orden
      session[:cart] = []

      # Redirigir al cliente a una página de éxito o a la página de la orden
      redirect_to order_path(order), notice: "Your order has been placed successfully!"
    else
      flash[:alert] = "Please log in to complete your order."
      redirect_to new_customer_session_path
    end
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = "There was an error processing your order: #{e.message}"
    redirect_to cart_path
  end

  private

  # Method to get the current cart
  def current_cart
    session[:cart] || []
  end
end
