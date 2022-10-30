require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'ユーザーモデルのバリデーションチェック' do
    let(:user1) { create(:user, :'山田太郎') }
    let(:user2) { create(:user, :'佐藤翼') }
    
    context 'データが有効なとき' do
      it '登録されること' do
        relationship = create(:relationship, follower_id: user1.id, followed_id: user2.id)
        expect(relationship).to be_valid
      end
    end
    
    context 'データが無効なとき' do
      it 'follower_idがなければ登録されないこと' do
        relationship = build(:relationship, follower_id: nil, followed_id: user2.id)
        relationship.valid?
        expect(relationship.errors[:follower_id]).to include('を入力してください')
      end
      
      it 'followed_idがなければ登録されないこと' do
        relationship = build(:relationship, follower_id: user1.id, followed_id: nil)
        relationship.valid?
        expect(relationship.errors[:followed_id]).to include('を入力してください')
      end
    end
  end
end
