class SearchesController < ApplicationController
  def index
    @pagy, @users = pagy(User.search(params[:word]))
    @pagy, @posts = pagy(Post.search(params[:word]))
  end
end
