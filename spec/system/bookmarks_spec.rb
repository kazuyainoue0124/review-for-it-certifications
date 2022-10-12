require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  let!(:certificate1) { create(:certificate, :a) }
  let!(:certificate2) { create(:certificate, :b) }
  let!(:user1) { create(:user, :a, certificate_id: certificate1.id) }
  let!(:user2) { create(:user, :b, certificate_id: certificate2.id) }
  let!(:post) { create(:post, certificate_id: certificate1.id, user_id: user2.id) }

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
