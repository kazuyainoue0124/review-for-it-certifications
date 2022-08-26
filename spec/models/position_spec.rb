require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'ポジション（職種）モデルのバリデーションチェック' do
    let(:position) { create(:position, :a) }
    # name
    let(:position_with_50_characters_name) { create(:position, :a, name: 'a' * 50) }
    let(:position_without_name) { build(:position, :a, name: nil) }
    let(:position_with_51_characters_name) { build(:position, :a, name: 'a' * 51) }
    let(:position_with_duplicate_name1) { create(:position, :a) }
    let(:position_with_duplicate_name2) { build(:position, :a) }

    context 'ポジション（職種）データが有効なとき' do
      it '名前が存在するなら有効である' do
        expect(position).to be_valid
      end
      it '名前が50文字以下なら有効である' do
        expect(position_with_50_characters_name).to be_valid
      end
    end

    context 'ポジション（職種）データが無効なとき' do
      it '名前がなければ無効である' do
        position_without_name.valid?
        expect(position_without_name.errors[:name]).to include("can't be blank")
      end

      it '名前が51文字以上なら無効である' do
        position_with_51_characters_name.valid?
        expect(position_with_51_characters_name.errors[:name]).to include('is too long (maximum is 50 characters)')
     end

      it '名前が重複しているなら無効である' do
        expect(position_with_duplicate_name1).to be_valid
        position_with_duplicate_name2.valid?
        expect(position_with_duplicate_name2.errors[:name]).to include('has already been taken')
      end
    end
  end
end
