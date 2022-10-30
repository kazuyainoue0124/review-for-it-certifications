require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user1) { create(:user, :'山田太郎') }
  let!(:user2) { create(:user, :'佐藤翼') }
  let(:user_params) { { user: attributes_for(:user, :'加藤健斗') } }
  let(:base_title) { 'シカクチコミ! - IT資格の口コミアプリ - ' }

  describe 'GET /new #new' do
    it 'タイトルが「新規登録|シカクチコミ!」であること' do
      get signup_path
      expect(response.body).to include full_title('新規登録')
    end
  end

  describe 'GET /:id #show' do
    it '他ユーザーの場合、タイトルが「ユーザー詳細|シカクチコミ!」であること' do
      log_in(user1)
      get user_path(user2)
      expect(response.body).to include full_title(user2.name)
    end

    it '自分の場合、タイトルが「マイページ|シカクチコミ!」であること' do
      log_in(user1)
      get user_path(user1)
      expect(response.body).to include full_title('マイページ')
    end
  end

  describe 'POST /users #create' do
    it '無効な値だと登録されないこと' do
      expect do
        post users_path, params: { user: { name: '',
                                           email: 'user@invalid',
                                           password: 'foo',
                                           password_confirmation: 'bar' } }
      end.to_not change(User, :count)
    end

    context '有効な値の場合' do
      it '登録されること' do
        expect do
          post users_path, params: user_params
        end.to change(User, :count).by 1
      end

      it 'root_pathにリダイレクトされること' do
          post users_path, params: user_params
        expect(response).to redirect_to root_path
      end

      it 'flashが表示されること' do
          post users_path, params: user_params
        expect(flash).to be_any
      end

      it 'ログイン状態であること' do
          post users_path, params: user_params
        expect(logged_in?).to be_truthy
      end
    end
  end

  describe 'GET /users/{id}/edit #edit' do
    it 'タイトルが「プロフィール編集|シカクチコミ!」であること' do
      log_in user1
      get edit_user_path(user1)
      expect(response.body).to include full_title('プロフィール編集')
    end

    context '未ログインの場合' do
      it 'flashが空でないこと' do
        get edit_user_path(user1)
        expect(flash).to_not be_empty
      end

      it 'ログインしてないユーザーはログインページにリダイレクトされること' do
        get edit_user_path(user1)
        expect(response).to redirect_to login_path
      end

      it 'ログインすると編集ページにリダイレクトされること' do
        get edit_user_path(user1)
        log_in user1
        expect(response).to redirect_to edit_user_path(user1)
      end
    end

    context '別のユーザーの場合' do

      it 'root_pathにリダイレクトされること' do
        log_in user1
        get edit_user_path(user2)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH /users #update' do
    it 'タイトルが「プロフィール編集|シカクチコミ!」であること' do
      log_in user1
      get edit_user_path(user1)
      expect(response.body).to include full_title('プロフィール編集')
    end

    context '無効な値の場合' do
      before do
        log_in user1
        patch user_path(user1), params: { user: { name: '',
                                                 email: 'foo@invalid',
                                                 password: 'foo',
                                                 password_confirmation: 'bar' } }
      end

      it '更新できないこと' do
        user1.reload
        expect(user1.name).to_not eq ''
        expect(user1.email).to_not eq ''
        expect(user1.password).to_not eq 'foo'
        expect(user1.password_confirmation).to_not eq 'bar'
      end

      it '更新後にプロフィールページが表示されていること' do
        expect(response.body).to include full_title('プロフィール編集')
      end
    end

    context 'ログインしてない場合' do
      it 'flashが空でないこと' do
        patch user_path(user1), params: { user: { name: user1.name,
                                                 email: user1.email } }
        expect(flash).to_not be_empty
      end

      it 'ログインしてないユーザーはログインページにリダイレクトされること' do
        patch user_path(user1), params: { user: { name: user1.name,
                                                 email: user1.email } }
        expect(response).to redirect_to login_path
      end
    end

    context '別のユーザーの場合' do
      before do
        log_in user1
        patch user_path(user2), params: { user: { name: user2.name,
                                                       email: user2.email } }
      end

      it 'root_pathにリダイレクトすること' do
        expect(response).to redirect_to root_path
      end
    end

    context '有効な値の場合' do
      before do
        log_in user1
        @name = 'Foo Bar'
        @email = 'foo@bar.com'
        patch user_path(user1), params: { user: { name: @name,
                                                 email: @email } }
      end

      it '更新できること' do
        user1.reload
        expect(user1.name).to eq @name
        expect(user1.email).to eq @email
      end

      it 'Users#showにリダイレクトすること' do
        expect(response).to redirect_to user1
      end

      it 'flashが表示されていること' do
        expect(flash).to be_any
      end
    end
  end
end
