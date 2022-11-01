require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let!(:user) { create(:user, :'山田太郎', email: 'yamada@gmail.com', password: 'password') }
  before do
    driven_by(:rack_test)
  end

  describe '#new' do
    context '有効な値の場合' do
      it 'ログインユーザー用のページレイアウトが表示されること' do
        visit login_path
        fill_in 'session[email]', with: 'yamada@gmail.com'
        fill_in 'session[password]',	with: 'password'
        click_button 'ログイン'
        expect(page).to_not have_selector "a[href=\"#{login_path}\"]"
        expect(page).to_not have_selector "a[href=\"#{signup_path}\"]"
        expect(page).to have_selector "a[href=\"#{new_post_path}\"]"
        expect(page).to have_selector "a[href=\"#{logout_path}\"]"
        expect(page).to have_selector "a[href=\"#{user_path(user)}\"]"
      end
    end

    context '値が入力されていない場合' do
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

    context 'メールアドレスが登録されていない場合' do
      it 'flashメッセージが表示されること' do
        visit login_path
        fill_in 'session[email]', with: 'taro@gmail.com'
        fill_in 'session[password]',	with: 'password'
        click_button 'ログイン'
        expect(page).to have_selector 'div.alert.alert-danger'
        visit root_path
        expect(page).to_not have_selector 'div.alert.alert-danger'
      end
    end

    context 'パスワードが間違っている場合' do
      it 'flashメッセージが表示されること' do
        visit login_path
        fill_in 'session[email]', with: 'yamada@gmail.com'
        fill_in 'session[password]',	with: 'yamadataro'
        click_button 'ログイン'
        expect(page).to have_selector 'div.alert.alert-danger'
        visit root_path
        expect(page).to_not have_selector 'div.alert.alert-danger'
      end
    end

    context 'テストユーザーでログインする場合' do
      let(:user) { create(:user, name: 'テストユーザー', email: 'test@example.com', password: 'password', password_confirmation: 'password')}
      it 'ボタンを押すだけでログインできること' do
        visit root_path
        click_button 'テストユーザーでログイン'
        expect(page).to_not have_selector "a[href=\"#{login_path}\"]"
        expect(page).to_not have_selector "a[href=\"#{signup_path}\"]"
        expect(page).to have_selector "a[href=\"#{new_post_path}\"]"
        expect(page).to have_selector "a[href=\"#{logout_path}\"]"
        expect(page).to have_selector "a[href=\"#{user_path(user)}\"]"
      end
    end
  end
end
