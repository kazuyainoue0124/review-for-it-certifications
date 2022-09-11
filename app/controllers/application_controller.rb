class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper

  private

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = 'ログインが必要です！'
    redirect_to login_path
  end
end
