class BookmarksController < ApplicationController
  before_action :logged_in_user

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id)
  end

  def create
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.new(user_id: current_user.id)
    bookmark.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = @post.bookmarks.find_by(user_id: current_user.id)
    bookmark.destroy if bookmark.present?
    redirect_to request.referer
  end
end
