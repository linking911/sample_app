class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    email = params[:session][:email]
    password = params[:session][:password]
    user = User.find_by(email: email.downcase)
    if user && user.authenticate(password)
      # ×¢²áÖ®ºóµÇÂ½
      sign_in user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user
    else
      flash.now[:error] = "Invalid email/password combination"
      render "new"
    end
  end
  
  def destroy
    signout
    redirect_to root_path
  end
end
