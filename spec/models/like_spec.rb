require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいね！モデルのバリデーションチェック' do
    let!(:certificate) { create(:certificate, :a) }
    let!(:position) { create(:position, :a) }

    context 'データが有効なとき' do
      let!(:user) { create(:user, :a) }
      let!(:post) { create(:post, certificate_id: certificate.id, user_id: user.id) }
      let(:like) { create(:like, :a, post_id: post.id, user_id: user.id) }

      it '登録されること' do
        expect(like).to be_valid
      end
    end

    context 'データが無効なとき' do
      let(:like_without_user_id) { build(:like, :a, user_id: nil) }
      let(:like_without_post_id) { build(:like, :a, post_id: nil) }

      it 'ユーザーIDがなければ登録されないこと' do
        like_without_user_id.valid?
        expect(like_without_user_id.errors[:user_id]).to include('を入力してください')
      end

      it 'ポストIDがなければ登録されないこと' do
        like_without_post_id.valid?
        expect(like_without_post_id.errors[:post_id]).to include('を入力してください')
      end
    end
  end
end
