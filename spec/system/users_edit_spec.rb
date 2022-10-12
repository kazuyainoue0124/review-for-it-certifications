require 'rails_helper'

RSpec.describe 'ログイン', type: :system do
  let!(:position) { create(:position, :a) }
  let!(:position) { create(:position, :b) }
  let!(:position) { create(:position, :c) }
  let!(:certificate) { create(:certificate, :a) }
  let!(:certificate) { create(:certificate, :b) }
  let!(:certificate) { create(:certificate, :c) }
  let(:user) { create(:user, :a, certificate_id: certificate.id) }

  before do
    driven_by(:rack_test)
  end

  scenario 'ユーザー編集が成功する' do
    visit login_path
    fill_in 'session[email]',	with: user.email
    fill_in 'session[password]',	with: user.password
    click_button 'ログイン'
    expect(page).to have_link(user.name)
    click_link user.name
    visit user_path(user)
    click_link '編集'
    visit edit_user_path(user)
    fill_in 'user[name]', with: 'user1Name'
    select position.name, from: 'user_position_id'
    fill_in 'user[job_change_count]', with: '3回'
    select '351~400万円', from: 'user_salary_before_two_years'
    select '351~400万円', from: 'user_salary_before_one_years'
    select '401~450万円', from: 'user_current_salary'
    select certificate.name, from: 'user_certificate_id'
    fill_in 'user[profile]', with: 'Hello, world!'
    click_button '保存'
    expect(page).not_to have_css 'div.alert-danger'
    expect(current_path).to eq user_path(user)
    expect(page).to have_css 'div.alert-success'
  end

  scenario 'ユーザー編集が失敗する' do
    visit login_path
    fill_in 'session[email]',	with: user.email
    fill_in 'session[password]',	with: user.password
    click_button 'ログイン'
    expect(page).to have_link(user.name)
    click_link user.name
    visit user_path(user)
    click_link '編集'
    fill_in 'user[name]', with: nil
    select position.name, from: 'user_position_id'
    fill_in 'user[job_change_count]', with: '3回'
    select '351~400万円', from: 'user_salary_before_two_years'
    select '351~400万円', from: 'user_salary_before_one_years'
    select '401~450万円', from: 'user_current_salary'
    select certificate.name, from: 'user_certificate_id'
    fill_in 'user[profile]', with: 'Hello, world!'
    click_button '保存'
    expect(page).to have_css 'div.alert-danger'
    expect(current_path).to eq user_path(user)
  end
end
