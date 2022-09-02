require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user, :a) }

  describe 'GET /new #new' do
    it 'タイトルが「ログイン|IT資格の口コミアプリ」であること' do
      get login_path
      expect(response.body).to include full_title('ログイン')
    end
  end

  describe 'POST /login #create' do
    before do
      post login_path, params: { session: { email: user.email, password: user.password } }
    end

    it 'ログイン時にセッションへユーザーIDが保存されること' do
      expect(is_logged_in?).to be_truthy
    end

    it 'root_pathにリダイレクトされること' do
      expect(response).to redirect_to root_path
    end

    it 'flashが表示されること' do
      expect(flash).to be_any
    end

    it 'ログイン状態であること' do
      expect(logged_in?).to be_truthy
    end
  end

  describe "DELETE /logout #destroy" do
    before do
      post login_path, params: { session: { email: user.email, password: user.password } }
    end

    it 'ログアウトできること' do
      expect(logged_in?).to be_truthy
      delete logout_path
      expect(logged_in?).to_not be_truthy
    end

    it '2回連続でログアウトしてもエラーにならないこと' do
      delete logout_path
      delete logout_path
      expect(response).to redirect_to root_path
    end
  end
  
end
