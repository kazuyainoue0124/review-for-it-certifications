class Api::V1::PostsController < ApiController
  def index
    posts = Post.joins(:user).select(:name, :title, :updated_at)
    render json: posts
  end

  def show
    post = Post.find(params[:id])
    render json: post
  end
end
