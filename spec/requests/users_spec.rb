require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:certificate1) { create(:certificate, :a) }
  let!(:certificate2) { create(:certificate, :b) }
  let!(:certificate3) { create(:certificate, :c) }
  let!(:user) { create(:user, :a, certificate_id: certificate1.id) }
  let!(:user) { create(:user, :a) }
  let(:user_params) { { user: attributes_for(:user, :a) } }
  let(:base_title) { 'IT資格の口コミアプリ' }

  describe 'GET /new #new' do
    it 'タイトルが「新規登録|IT資格の口コミアプリ」であること' do
      get signup_path
      expect(response.body).to include full_title('新規登録')
    end
  end

  describe 'GET /:id #show' do
    let!(:another_user) { create(:user, :b, certificate_id: certificate2.id) }
    it '他ユーザーの場合、タイトルが「ユーザー詳細|IT資格の口コミアプリ」であること' do
      log_in(user)
      get user_path(another_user)
      expect(response.body).to include full_title(another_user.name)
    end

    it '自分の場合、タイトルが「マイページ|IT資格の口コミアプリ」であること' do
      log_in(user)
      get user_path(user)
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

  # describe 'get /users' do
  #   it 'ログインしていなければログインページにリダイレクトするること' do
  #     get users_path
  #     expect(response).to redirect_to login_path
  #   end
  # end

  describe 'GET /users/{id}/edit #edit' do
    it 'タイトルが「プロフィール編集|IT資格の口コミアプリ」であること' do
      log_in user
      get edit_user_path(user)
      expect(response.body).to include full_title('プロフィール編集')
    end

    context '未ログインの場合' do
      it 'flashが空でないこと' do
        get edit_user_path(user)
        expect(flash).to_not be_empty
      end

      it 'ログインしてないユーザーはログインページにリダイレクトされること' do
        get edit_user_path(user)
        expect(response).to redirect_to login_path
      end

      it 'ログインすると編集ページにリダイレクトされること' do
        get edit_user_path(user)
        log_in user
        expect(response).to redirect_to edit_user_path(user)
      end
    end

    context '別のユーザーの場合' do
      let(:other_user) { create(:user, :b) }

      it 'root_pathにリダイレクトされること' do
        log_in user
        get edit_user_path(other_user)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH /users #update' do
    it 'タイトルが「プロフィール編集|IT資格の口コミアプリ」であること' do
      log_in user
      get edit_user_path(user)
      expect(response.body).to include full_title('プロフィール編集')
    end

    context '無効な値の場合' do
      before do
        log_in user
        patch user_path(user), params: { user: { name: '',
                                                 email: 'foo@invalid',
                                                 password: 'foo',
                                                 password_confirmation: 'bar' } }
      end

      it '更新できないこと' do
        user.reload
        expect(user.name).to_not eq ''
        expect(user.email).to_not eq ''
        expect(user.password).to_not eq 'foo'
        expect(user.password_confirmation).to_not eq 'bar'
      end

      it '更新後にマイページが表示されていること' do
        expect(response.body).to include full_title('プロフィール編集')
      end
    end

    context 'ログインしてない場合' do
      it 'flashが空でないこと' do
        patch user_path(user), params: { user: { name: user.name,
                                                 email: user.email } }
        expect(flash).to_not be_empty
      end

      it 'ログインしてないユーザーはログインページにリダイレクトされること' do
        patch user_path(user), params: { user: { name: user.name,
                                                 email: user.email } }
        expect(response).to redirect_to login_path
      end
    end

    context '別のユーザーの場合' do
      let(:other_user) { create(:user, :b) }

      before do
        log_in user
        patch user_path(other_user), params: { user: { name: other_user.name,
                                                       email: other_user.email } }
      end

      it 'root_pathにリダイレクトすること' do
        expect(response).to redirect_to root_path
      end
    end

    context '有効な値の場合' do
      before do
        log_in user
        @name = 'Foo Bar'
        @email = 'foo@bar.com'
        patch user_path(user), params: { user: { name: @name,
                                                 email: @email } }
      end

      it '更新できること' do
        user.reload
        expect(user.name).to eq @name
        expect(user.email).to eq @email
      end

      it 'Users#showにリダイレクトすること' do
        expect(response).to redirect_to user
      end

      it 'flashが表示されていること' do
        expect(flash).to be_any
      end
    end
  end
end
