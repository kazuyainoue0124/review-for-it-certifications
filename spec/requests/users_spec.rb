require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user, :a) }
  let(:params) { { user: attributes_for(:user, :a) } }

  describe 'GET /new' do
    it 'returns http success' do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end
  
  describe 'POST /create', type: :request do
    it 'ユーザー登録時にセッションへユーザーIDが保存されること' do
      post users_path, params: params
      expect(response).to have_http_status(:found)
      expect(is_logged_in?).to be_truthy
    end
  end

  describe 'GET /:id' do
    it 'returns http success' do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end
end
