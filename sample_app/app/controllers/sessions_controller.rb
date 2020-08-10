class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t "session.success_login_notify"
      remember_user user
    else
      flash[:danger] = t "session.failed_login_notify"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def remember_user user
    if user.activated?
      log_in user
      params[:session][:remember_me] == Settings.user.checkbox_value ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t "shared.account_not_activated"
      redirect_to root_url
    end
  end
end
