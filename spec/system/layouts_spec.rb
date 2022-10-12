require 'rails_helper'

RSpec.describe 'Layouts', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:certificate1) { create(:certificate, :a) }
  let(:user) { create(:user, :a, certificate_id: certificate1.id) }

  describe 'header' do
    context 'ログイン済の場合' do
      before do
        log_in user
        visit root_path
      end

      it 'タイトルをクリックするとトップページに遷移すること' do
        click_link 'IT資格の口コミアプリ!!'
        expect(page.current_path).to eq root_path
      end

      it '「投稿する」をクリックすると新規投稿画面に遷移すること' do
        click_link '投稿する'
        expect(page.current_path).to eq new_post_path
      end

      it '「ログアウト」をクリックするとログアウトしてトップページにリダイレクトすること' do
        click_link 'ログアウト'
        expect(page.current_path).to eq root_path
      end
    end

    context '未ログインの場合' do
      before do
        visit root_path
      end

      it 'タイトルをクリックするとトップページに遷移すること' do
        click_link 'IT資格の口コミアプリ!!'
        expect(page.current_path).to eq root_path
      end

      it '「ログイン」をクリックするとログインページに遷移すること' do
        click_link 'ログイン'
        expect(page.current_path).to eq login_path
      end

      it '「新規登録」をクリックすると新規登録ページに遷移すること' do
        click_link '新規登録'
        expect(page.current_path).to eq signup_path
      end
    end
  end
end
