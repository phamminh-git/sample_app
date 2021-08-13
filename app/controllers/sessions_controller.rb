class SessionsController < ApplicationController
  def new
    redirect_to current_user if logged_in?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    remember_value = params[:session][:remember_me]
    if user&.authenticate params[:session][:password]
      login_activated_user user, remember_value
    else
      flash[:danger] = t "sessions.message.login_fail"
      render :new
    end
  end

  def destroy
    if logged_in?
      forget current_user
      log_out
    end
    redirect_to root_path
  end

  def login_activated_user user, remember_value
    if user.activated
      login user, remember_value
      redirect_back_or user
    else
      flash[:warning] = t "sessions.message.activate_message"
      redirect_to root_url
    end
  end

  def login user, remember_value
    flash[:sucess] = t "sessions.message.login_success"
    log_in user
    remember_value == "1" ? remember(user) : forget(user)
  end
end
