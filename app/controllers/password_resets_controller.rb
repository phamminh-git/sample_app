class PasswordResetsController < ApplicationController
  before_action :get_user, only: %i(edit update)
  before_action :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "user_mailer.password_reset.success"
      redirect_to root_url
    else
      flash.now[:danger] = t "user_mailer.password_reset.not_found"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_attribute :reset_digest, nil
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    return if @user.authenticated? :reset, params[:id]

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "user_mailer.password_reset.expired"
    redirect_to password_reset_new_url
  end
end
