class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'ログインに成功しました！'
      redirect_to root_path
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'メールアドレスまたはパスワードに誤りがあります！'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました！'
    redirect_to root_path
  end
end
