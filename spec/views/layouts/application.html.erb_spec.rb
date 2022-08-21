require 'rails_helper'

RSpec.describe 'layouts/application.html.erb', type: :view do
  describe 'トップページへアクセス', type: :feature do
    before do
      visit root_path
    end
    it 'タイトルが表示されること' do
      expect(page).to have_link 'IT資格の口コミアプリ'
    end

    it 'ログインリンクが表示されること' do
      expect(page).to have_link 'ログイン'
    end

    it 'ユーザー登録リンクが表示されること' do
      expect(page).to have_link '新規登録'
    end

    it '検索欄が表示されること' do
      expect(page).to have_selector 'input[type=search]'
    end

    it '検索ボタンが表示されること' do
      expect(page).to have_button 'Search'
    end
  end
end
