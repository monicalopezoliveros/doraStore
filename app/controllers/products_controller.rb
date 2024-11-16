class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  # GET /products
  def index
    @products = Product.all
    #busca deacuerdo a una condicion que esta en onsale
    # @products = Product.includes(:category).where(status_flag: :On_sale).order(created_at: :desc)
  end

  # GET /products/:id
  def show
  end

  private

  # Find the product by its ID
  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "El producto que buscas no existe."
  end
end
