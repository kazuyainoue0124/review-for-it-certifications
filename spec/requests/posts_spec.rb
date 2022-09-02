require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:post_params) { { post: attributes_for(:post) } }

  describe 'GET /index #index' do
    it 'タイトルが「ログイン|IT資格の口コミアプリ」であること' do
      get posts_path
      expect(response.body).to include full_title('ホーム')
    end
  end

  describe 'POST /posts #create' do
    context '未ログインの場合' do
      it '登録されないこと' do
        expect {
          post posts_path, params: post_params
        }.to_not change(Post, :count)
      end
      it 'ログインページへリダイレクトされること' do
        post posts_path, params: post_params
        expect(response).to redirect_to login_path
      end
    end
  end
  
end
