class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username].downcase)
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to venues_url
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to login_url
    end
  end

  def destroy
    log_out
    redirect_to venues_url
  end
end
