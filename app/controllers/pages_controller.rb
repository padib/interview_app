class PagesController < ApplicationController
  def home
    @title = "Home"
    if signed_in?
      @recipe = Recipe.new
      @recipebox_items = current_user.recipebox.paginate(:page => params[:page])
    end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

end
