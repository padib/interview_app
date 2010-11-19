class SessionsController < ApplicationController
  def new
    @title = "Log in"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil? 
      #TODO Replace this with just plain flash[:error] so it lasts too long
      flash.now[:error] = "Invalid email/password combination." 
      @title = "Sign in" 
      render 'new'
    else 
      sign_in user 
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
