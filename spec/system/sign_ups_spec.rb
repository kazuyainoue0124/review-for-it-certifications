require 'rails_helper'

RSpec.describe '新規登録', type: :system do
  let(:user) { build(:user, :a) }

  before do
    driven_by(:rack_test)
  end

  scenario 'ユーザーの新規登録が成功する' do
    visit root_path
    expect(page).to have_link('新規登録')
    click_link '新規登録'
    visit signup_path
    expect do
      fill_in 'user[name]',	with: user.name
      fill_in 'user[email]',	with: user.email
      fill_in 'user[password]',	with: user.password
      fill_in 'user[password_confirmation]',	with: user.password_confirmation
      click_button '登録'
    end.to change { User.count }.by(1)
    expect(current_path).to eq root_path
    expect(page).to have_css 'div.alert-success'
    expect(page).not_to have_link('ログイン')
    expect(page).not_to have_link('新規登録')
    expect(page).to have_link('投稿する')
    expect(page).to have_link('ログアウト')
  end

  scenario 'ユーザーの新規登録が失敗する' do
    visit root_path
    expect(page).to have_link('新規登録')
    click_link '新規登録'
    visit signup_path
    expect do
      fill_in 'user[name]',	with: ' '
      fill_in 'user[email]',	with: 'user@invalid'
      fill_in 'user[password]',	with: 'foo'
      fill_in 'user[password_confirmation]',	with: 'bar'
      click_button '登録'
    end.to change { User.count }.by(0)
    expect(current_path).to eq '/users'
    expect(page).to have_css 'div.alert-danger'
  end
end
