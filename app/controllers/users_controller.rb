class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)

  def new
    redirect_to(root_path) if logged_in?
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "users.create.info"
      redirect_to login_url
    else
      flash[:danger] = t "users.create.fail"
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t "users.update.success"
      redirect_to @user
    else
      flash[:danger] = t "users.update.fail"
      render :edit
    end
  end

  def destroy
    if current_user.admin && @user != current_user && @user.destroy
      flash[:success] = t "users.destroy.sucess"
    else
      flash[:danger] = t "users.destroy.fail"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit User::PARAMS
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash["danger"] = t "users.index.login_message"
    redirect_to login_path
  end

  def correct_user
    redirect_to(root_path) unless @user == current_user
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.index.not_found"
    redirect_to root_path
  end
end
