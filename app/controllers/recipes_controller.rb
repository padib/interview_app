class RecipesController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  def create
    @recipe = current_user.recipes.build(params[:recipe])
    if @recipe.save
      flash[:success] = "Now we're cooking!"
      redirect_to root_path
    else
      @recipebox_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @recipe.destroy
    redirect_back_or_root_path
  end

  private
    def authorized_user
      @recipe = Recipe.find(params[:id])
      redirect_to root_path unless current_user?(@recipe.user)
    end
end
