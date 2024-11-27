class OrdersController < ApplicationController
  before_action :authenticate_customer! # Asegura que el cliente esté autenticado

  def create
    @cart = current_cart
    @customer = current_customer

    if @cart.empty?
      flash[:alert] = "Your cart is empty."
      redirect_to products_path
      return
    end

    # Comenzamos una transacción para crear la orden y sus detalles
    ActiveRecord::Base.transaction do
      # Crear la orden (status inicial es "pending")
      @order = @customer.orders.create!(status: :pending)

      # Crear los detalles de la orden a partir del carrito
      @cart.each do |item|
        product = Product.find(item["product_id"])
        @order.order_details.create!(
          product: product,
          quantity: item["quantity"],
          unit_price: item["price"]
        )
      end

      # Limpiar el carrito después de crear la orden
      session[:cart] = []

      # Redirigir al cliente a la página de la orden
      redirect_to order_path(@order), notice: "Your order has been placed successfully!"
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "There was an issue with your order: #{e.message}"
      render 'carts/checkout_form' # Redirige al formulario de checkout si algo falla
    end
  end
end
