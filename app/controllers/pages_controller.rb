class PagesController < ApplicationController
  def show
    @page = Page.find_by(title: params[:title])
    unless @page
      render plain: "Page not found", status: :not_found
    end
  end

  def about
    @about_page = Page.find_by(title: 'About')  # Busca la página con el título 'About'
    unless @about_page
      render plain: "About page not found", status: :not_found  # Si no se encuentra la página About
    end
  end
end
