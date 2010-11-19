class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :index, :update]
  before_filter :admin_user,	:only => :destroy
  
  def new
    @user = User.new
    @title = "Sign Up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @recipes = @user.recipes.paginate(:page => params[:page])
  end
  
  def index
    @title = "Meet everybody"
    @users = User.paginate(:page => params[:page])
  end
  
  def create
    @user = User.new(params[:user]) 
    if @user.save
      sign_in @user
      flash[:success] = "Congratulations, and thanks for signing up!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new' 
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit yourself" 
  end
  
  def update
    @user = User.find(params[:id]) 
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user 
    else
      @title = "Edit user"
      render 'edit' 
    end
  end
  
  def destroy
    User.find(params[:id]).destroy 
    flash[:success] = "User destroyed." 
    redirect_to users_path
  end
  
  private
    
    def admin_user
      redirect_to(root_path) unless (current_user && current_user.admin?)
        
    end
end
