require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  let!(:certificate1) { create(:certificate, :a) }
  let!(:certificate2) { create(:certificate, :b) }
  let!(:user1) { create(:user, :a, certificate_id: certificate1.id) }
  let!(:user2) { create(:user, :b, certificate_id: certificate2.id) }
  before do
    driven_by(:rack_test)
  end

  describe '#create, #destroy' do
    it 'ユーザーをフォロー、フォロー解除できる' do
      log_in user1
      visit user_path(user2)
      click_link 'フォロー'
      expect(user2.followers.count).to eq(1)
      expect(user1.followings.count).to eq(1)

      click_link 'フォロー解除'
      expect(user2.followers.count).to eq(0)
      expect(user1.followings.count).to eq(0)
    end
  end
end
