require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user, :a) }

  describe 'GET /new' do
    it 'returns http success' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create', type: :request do
    it 'ログイン時にセッションへユーザーIDが保存されること' do
      post login_path, params: { session: {
        email: user.email,
        password: user.password
      } }
      expect(response).to have_http_status(:found)
      expect(is_logged_in?).to be_truthy
    end
  end

  describe 'DELETE /destroy', type: :request do
    it 'ログアウト時にセッションからユーザーIDが削除されること' do
      post login_path, params: { session: {
        email: user.email,
        password: user.password
      } }
      expect(response).to have_http_status(:found)
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(response).to have_http_status(:found)
      expect(is_logged_in?).to be_falsey
    end
  end
end
