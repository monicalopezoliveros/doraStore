class OrdersController < ApplicationController
  before_action :authenticate_customer! # Ensures that the client is authenticated

  def create
    @cart = current_cart
    @customer = current_customer

    if @cart.empty?
      flash[:alert] = "Your cart is empty."
      redirect_to products_path
      return
    end

    # A transaction is started to create the order and its details.
    ActiveRecord::Base.transaction do
      # Create the order (initial status is "pending")
      @order = @customer.orders.create!(status: :pending)

      # Create order details from cart
      @cart.each do |item|
        product = Product.find(item["product_id"])
        @order.order_details.create!(
          product: product,
          quantity: item["quantity"],
          unit_price: item["price"]
        )
      end

      # Clear the cart after creating the order
      session[:cart] = []

      # Redirect the customer to the order page
      redirect_to order_path(@order), notice: "Your order has been placed successfully!"
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "There was an issue with your order: #{e.message}"
      render 'carts/checkout_form' # Redirect to the checkout form if something goes wrong
    end
  end

  # Show order details
  def show
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Order not found."
    redirect_to root_path
  end
end
