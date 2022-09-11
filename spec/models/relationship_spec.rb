require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'ユーザーモデルのバリデーションチェック' do
    context 'データが有効なとき' do
      let(:relationship) { create(:relationship, :a) }

      it '登録されること' do
        expect(relationship).to be_valid
      end
    end

    context 'データが無効なとき' do
      let(:relationship_without_follower_id) { build(:relationship, :a, follower_id: nil) }
      let(:relationship_without_followed_id) { build(:relationship, :a, followed_id: nil) }

      it 'follower_idがなければ登録されないこと' do
        relationship_without_follower_id.valid?
        expect(relationship_without_follower_id.errors[:follower_id]).to include('を入力してください')
      end

      it 'followeD_idがなければ登録されないこと' do
        relationship_without_followed_id.valid?
        expect(relationship_without_followed_id.errors[:followed_id]).to include('を入力してください')
      end
    end
  end
end
