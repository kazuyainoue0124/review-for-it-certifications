require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let(:user) { build(:user, :a) }
  before do
    driven_by(:rack_test)
  end

  describe '#create' do
    context '有効な値の場合' do
      it 'ユーザーが新規登録されること' do
        visit signup_path

        expect do
          fill_in 'user[name]', with: user.name
          fill_in 'user[email]', with: user.email
          fill_in 'user[password]',	with: user.password
          fill_in 'user[password_confirmation]',	with: user.password_confirmation
          click_button '登録'
        end.to change(User, :count).by 1
        expect(page).to have_content '新規登録が完了しました！'
      end
    end

    context '無効な値の場合' do
      it 'エラーメッセージが表示されること' do
        visit signup_path

        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: 'user@invalid'
        fill_in 'user[password]',	with: 'foo'
        fill_in 'user[password_confirmation]',	with: 'bar'
        click_button '登録'

        expect(page).to have_selector 'div#error_explanation'
        expect(page).to have_selector 'div.field_with_errors'
      end
    end
  end
end
