require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいね！モデルのバリデーションチェック' do
    let(:certificate) { create(:certificate, :'ITパスポート') }
    let(:user) { create(:user, :'山田太郎') }
    let(:post) { create(:post, :'ITパスポートに合格しました!', user_id: user.id, certificate_id: certificate.id) }

    context 'データが有効なとき' do
      it '登録されること' do
        another_user = create(:user, :'佐藤翼')
        like = create(:like, user_id: another_user.id, post_id: post.id)
        expect(like).to be_valid
      end
    end

    context 'データが無効なとき' do
      it 'ユーザーIDがなければ登録されないこと' do
        like = build(:like, user_id: nil, post_id: post.id)
        like.valid?
        expect(like.errors[:user_id]).to include('を入力してください')
      end

      it 'ポストIDがなければ登録されないこと' do
        another_user = create(:user, :'佐藤翼')
        like = build(:like, user_id: another_user.id, post_id: nil)
        like.valid?
        expect(like.errors[:post_id]).to include('を入力してください')
      end
    end
  end
end
