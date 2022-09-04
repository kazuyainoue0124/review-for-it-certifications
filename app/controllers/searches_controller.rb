class SearchesController < ApplicationController
  def index
    @users = User.search(params[:word])
    @posts = Post.search(params[:word])
  end
end
