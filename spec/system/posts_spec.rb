require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let!(:certificate) { create(:certificate, :a) }
  let!(:user) { create(:user, :a, certificate_id: certificate.id) }
  let(:post) { build(:post) }

  before do
    driven_by(:rack_test)
    log_in user
    visit new_post_path
  end

  describe '#create' do
    context '有効な送信の場合' do
      it '投稿されること' do
        expect do
          fill_in 'post_title', with: post.title
          select '基本情報技術者', from: 'post_certificate_id'
          select '~1ヶ月', from: 'post_study_period'
          fill_in 'post_how_to_study',	with: post.how_to_study
          select 'すごく役に立った', from: 'post_valuable_score'
          fill_in 'post_how_change',	with: post.how_change
          select 'すごくおすすめ', from: 'post_recommend_score'
          fill_in 'post_recommended_person',	with: post.recommended_person
          fill_in 'post_comment',	with: post.comment
          click_button '投稿'
        end.to change(Post, :count).by 1
        expect(page).to have_content '記事を投稿しました！'
      end
    end

    context '無効な送信の場合' do
      it '内容が空なら投稿されないこと' do
        fill_in 'post_title', with: ''
        select '選択してください', from: 'post_certificate_id'
        select '選択してください', from: 'post_study_period'
        fill_in 'post_how_to_study',	with: ''
        select '選択してください', from: 'post_valuable_score'
        fill_in 'post_how_change',	with: ''
        select '選択してください', from: 'post_recommend_score'
        fill_in 'post_recommended_person',	with: ''
        fill_in 'post_comment',	with: ''
        click_button '投稿'
        expect(page).to have_selector 'div.alert.alert-danger'
      end
    end
  end
end
