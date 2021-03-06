class SessionsController < ApplicationController
  
  def new
    
  end

  def create
    @user = User.find_by_email(params[:email].downcase)
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      session[:user_id] = @user.id
      redirect_to [:root]
    else
      flash.now.alert = "Email or passowrd is invalid"
      redirect_to [:new, :session]
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:root]
  end

end
