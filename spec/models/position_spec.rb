require 'rails_helper'

RSpec.describe Position, type: :model do
  describe 'ポジション（職種）モデルのバリデーションチェック' do
    context 'ポジション（職種）データが有効なとき' do
      it '名前が存在するなら有効である' do
        position = create(:position, name: 'システムエンジニア')
        expect(position).to be_valid
      end
      it '名前が50文字以下なら有効である' do
        position = create(:position, name: 'a' * 50)
        expect(position).to be_valid
      end
    end
    
    context 'ポジション（職種）データが無効なとき' do
      it '名前がなければ無効である' do
        position = build(:position, name: nil)
        position.valid?
        expect(position.errors[:name]).to include('を入力してください')
      end
      
      it '名前が51文字以上なら無効である' do
        position = build(:position, name: 'a' * 51)
        position.valid?
        expect(position.errors[:name]).to include('は50文字以内で入力してください')
      end

      it '名前が重複しているなら無効である' do
        position = create(:position, name: 'システムエンジニア')
        expect(position).to be_valid
        another_position = build(:position, name: 'システムエンジニア')
        another_position.valid?
        expect(another_position.errors[:name]).to include('はすでに存在します')
      end
    end
  end
end
