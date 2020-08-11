class FollowingController < ApplicationController
  before_action :logged_in_user
  before_action :find_user

  def index
    @title = t "user.stats.following"
    @users = @user.following.page params[:page]
    render "users/show_follow"
  end
end
