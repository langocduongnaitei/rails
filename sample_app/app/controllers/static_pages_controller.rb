class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.created_post_at.page(params[:page]).per Settings.pagination
  end
  def help; end

  def about; end

  def contact; end
end
