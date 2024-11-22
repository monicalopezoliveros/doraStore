class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  # GET /products
  def index
    @products = Product.includes(:category).order(created_at: :desc)

    # Filter by keyword
    if params[:query].present?
      @query = params[:query]
      @products = @products.where("name LIKE ? OR metal LIKE ?", "%#{@query}%", "%#{@query}%")
    end

    # Filter by category
    if params[:category].present?
      @category = params[:category]
      @products = @products.joins(:category).where(categories: { name: @category })
    end

    # Pagination
    @products = @products.page(params[:page]).per(8)
  end


  # GET /products/:id
  def show
    product = Product.find(params[:id])

  end

  private

  # Find the product by its ID
  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "The product you are looking for does not exist."
  end

end
