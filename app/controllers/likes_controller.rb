class LikesController < ApplicationController
  before_action :logged_in_user

  def index
    @pagy, @likes = pagy(Like.where(user_id: current_user.id))
  end

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.new(user_id: current_user.id)
    like.save
    redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user_id: current_user.id)
    like.destroy if like.present?
    redirect_to request.referer
  end
end
