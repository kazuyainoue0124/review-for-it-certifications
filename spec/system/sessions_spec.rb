require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe '#new' do
    context '有効な値の場合' do
      let(:user) { create(:user, :a) }
      it 'ログインユーザー用のページレイアウトが表示されること' do
        visit login_path
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]',	with: user.password
        click_button 'ログイン'
        expect(page).to_not have_selector "a[href=\"#{login_path}\"]"
        expect(page).to_not have_selector "a[href=\"#{signup_path}\"]"
        expect(page).to have_selector "a[href=\"#{new_post_path}\"]"
        expect(page).to have_selector "a[href=\"#{logout_path}\"]"
        expect(page).to have_selector "a[href=\"#{user_path(user)}\"]"
      end
    end

    context '無効な値の場合' do
      it 'flashメッセージが表示されること' do
        visit login_path
        fill_in 'session[email]', with: ''
        fill_in 'session[password]',	with: ''
        click_button 'ログイン'
        expect(page).to have_selector 'div.alert.alert-danger'
        visit root_path
        expect(page).to_not have_selector 'div.alert.alert-danger'
      end
    end
  end
end
