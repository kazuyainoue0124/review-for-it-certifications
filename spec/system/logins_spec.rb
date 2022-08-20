require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  let(:user) { create(:user, :a) }

  before do
    driven_by(:rack_test)
  end

  scenario 'ユーザーのログインが成功する' do
    visit root_path
    expect(page).to have_link('ログイン')
    click_link 'ログイン'
    visit login_path
    fill_in 'session[email]',	with: user.email
    fill_in 'session[password]',	with: user.password
    click_button 'ログイン'
    expect(current_path).to eq root_path
    expect(page).to have_css 'div.alert-success'
    expect(page).not_to have_link('ログイン')
    expect(page).not_to have_link('新規登録')
    expect(page).to have_link('投稿する')
    expect(page).to have_link('ログアウト')
    click_link 'ログアウト'
    expect(current_path).to eq root_path
    expect(page).to have_link('ログイン')
    expect(page).to have_link('新規登録')
    expect(page).not_to have_link('投稿する')
    expect(page).not_to have_link('ログアウト')
  end

  scenario 'ユーザーのログインが失敗する' do
    visit root_path
    expect(page).to have_link('ログイン')
    click_link 'ログイン'
    visit login_path
    fill_in 'session[email]',	with: 'あああ'
    fill_in 'session[password]',	with: 'aaaaaa'
    click_button 'ログイン'
    expect(current_path).to eq login_path
    expect(page).to have_css 'div.alert-danger'
  end
end
