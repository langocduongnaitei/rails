class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :build_micropost, only: :create

  def create
    if @micropost.save
      flash[:success] = t ".micropost_created"
      redirect_to root_url
    else
      flash[:danger] = t ".micropost_fail"
      @feed_items = current_user.feed.page params[:page]
      render "static_pages/home"
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t "microposts.micropost_deleted"
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::PARAMS
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "login.login_danger"
    redirect_to login_url
  end

  def build_micropost
    @micropost = current_user.microposts.build micropost_params
  end
end
