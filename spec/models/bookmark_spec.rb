require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'ブックマークモデルのバリデーションチェック' do
    let(:certificate) { create(:certificate, :'ITパスポート') }
    let(:user) { create(:user, :'山田太郎') }
    let(:post) { create(:post, :'ITパスポートに合格しました!', user_id: user.id, certificate_id: certificate.id) }

    context 'データが有効なとき' do
      it '登録されること' do
        another_user = create(:user, :'佐藤翼')
        bookmark = create(:bookmark, user_id: another_user.id, post_id: post.id)
        expect(bookmark).to be_valid
      end
    end
    
    context 'データが無効なとき' do
      it 'ユーザーIDがなければ登録されないこと' do
        bookmark = build(:bookmark, user_id: nil, post_id: post.id)
        bookmark.valid?
        expect(bookmark.errors[:user_id]).to include('を入力してください')
      end
      
      it 'ポストIDがなければ登録されないこと' do
        another_user = create(:user, :'佐藤翼')
        bookmark = build(:bookmark, user_id: another_user.id, post_id: nil)
        bookmark.valid?
        expect(bookmark.errors[:post_id]).to include('を入力してください')
      end
    end
  end
end
