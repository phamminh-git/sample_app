class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:sucess] = t "sessions.message.login_success"
      log_in user
      redirect_to user
    else
      flash[:danger] = t "sessions.message.login_fail"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
