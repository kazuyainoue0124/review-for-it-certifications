class RelationshipsController < ApplicationController
  # フォローする
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  # フォローを外す
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @pagy, @users = pagy(user.followings, items: 5)
    @certificate_ranks = Certificate.create_certificate_ranks
    @follower_ranks = User.create_follower_ranks
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @pagy, @users = pagy(user.followers, items: 5)
    @certificate_ranks = Certificate.create_certificate_ranks
    @follower_ranks = User.create_follower_ranks
  end
end
