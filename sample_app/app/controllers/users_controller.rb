class UsersController < ApplicationController
  before_action :logged_in_user, except: :show
  before_action :find_user, only: %i(show edit destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.pagination
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t "shared.success"
      redirect_to @user
    else
      flash[:danger] = t "shared.danger"
      render :new
    end
  end

  def show
    @user = User.find params[:id]
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "edit.edit_success"
      log_in @user
      redirect_to @user
    else
      flash[:danger] = t "edit.edit_danger"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "shared.user_deleted"
    else
      flash[:danger] = t "shared.delete_danger"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USERS_PARAMS
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".flash"
    redirect_to root_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "login.login_danger"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
