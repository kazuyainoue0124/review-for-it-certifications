class SearchesController < ApplicationController
  def index
    @pagy, @users = pagy(User.search(params[:id], params[:word]), items: 5)
    @pagy, @posts = pagy(Post.search(params[:id], params[:word]), items: 5)
    @certificate_ranks = Certificate.create_certificate_ranks
    @follower_ranks = User.create_follower_ranks
  end
end
