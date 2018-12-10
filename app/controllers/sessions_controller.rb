class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])
    # user = User.find_by_email(params[:email])
    # if user && user.authenticate(params[:password])
    if user
      # Save the user id to browser cookie
      # If the user exists AND the password entered is correct
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
