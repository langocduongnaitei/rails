class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t "user.stats.followers"
    @users = @user.followers.page params[:page]
    render "users/show_follow"
  end
end
