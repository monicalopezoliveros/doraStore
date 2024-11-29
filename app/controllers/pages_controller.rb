class PagesController < ApplicationController
  def show
    @page = Page.find_by(title: params[:title])
    unless @page
      render plain: "Page not found", status: :not_found
    end
  end

  def about
    @about_page = Page.find_by(title: 'About')  # Find the page with the title 'About'
    unless @about_page
      render plain: "About page not found", status: :not_found  # If the About page is not found
    end
  end

  def contact
    @contact_page = Page.find_by(title: 'Contact')
    unless @contact_page
      render plain: "Contact page not found", status: :not_found
    end
  end
end
