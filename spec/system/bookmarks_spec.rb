require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  let!(:certificate) { create(:certificate, :'ITパスポート') }
  let!(:user1) { create(:user, :'山田太郎') }
  let!(:user2) { create(:user, :'佐藤翼', certificate_id: certificate.id) }
  let!(:post) { create(:post, :'ITパスポートに合格しました!', certificate_id: certificate.id, user_id: user2.id) }

  before do
    driven_by(:rack_test)
  end

  describe '#create, #destroy' do
    it '記事をブックマーク、ブックマーク解除できる' do
      log_in user1
      visit post_path(post)
      click_link 'ブックマーク'
      expect(user1.bookmarks.count).to eq(1)

      click_link 'ブックマークを外す'
      expect(user1.bookmarks.count).to eq(0)
    end
  end
end
