class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    remember_value = params[:session][:remember_me]
    if user&.authenticate params[:session][:password]
      login user, remember_value
      redirect_to user
    else
      flash[:danger] = t "sessions.message.login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def login user, remember_value
    flash[:sucess] = t "sessions.message.login_success"
    log_in user
    remember_value == "1" ? remember(user) : forget(user)
  end
end
