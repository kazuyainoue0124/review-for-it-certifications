class SearchesController < ApplicationController
  def index
    @pagy, @users = pagy(User.search(params[:word]))
    @pagy, @posts = pagy(Post.search(params[:word]))
    @certificate_ranks = Certificate.create_certificate_ranks
    @follower_ranks = User.create_follower_ranks
  end
end
