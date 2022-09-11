class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create destroy]
  def index
    @pagy, @posts = pagy(Post.all)
  end

  def new
    @post = current_user.posts.build if logged_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '記事を投稿しました！'
      redirect_to user_path(current_user)
    else
      render 'posts/new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = '変更を保存しました！'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy; end

  private

  def post_params
    params.require(:post).permit(:title, :certificate_id, :study_period, :how_to_study, :valuable_score, :how_change, :recommend_score, :recommended_person,
                                 :comment)
  end
end
