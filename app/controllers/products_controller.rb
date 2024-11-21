class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  # GET /products
  def index
    @products = Product.includes(:category).order(created_at: :desc).page(params[:page]).per(8)
    # @products = Product.all
    #busca deacuerdo a una condicion que esta en onsale
    # @products = Product.includes(:category).where(status_flag: :On_sale).order(created_at: :desc)
  end

  # GET /products/:id
  def show
    product = Product.find(params[:id])
    render json: { price: product.price }

  end

  private

  # Find the product by its ID
  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "The product you are looking for does not exist."
  end

end
