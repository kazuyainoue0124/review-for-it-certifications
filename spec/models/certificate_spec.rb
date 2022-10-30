require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe '資格モデルのバリデーションチェック' do
    context '資格データが有効なとき' do
      it '名前が存在するなら有効である' do
        certificate = create(:certificate, name: 'ITパスポート')
        expect(certificate).to be_valid
      end
      it '名前が50文字以下なら有効である' do
        certificate = create(:certificate, name: 'a' * 50)
        expect(certificate).to be_valid
      end
    end
    
    context '資格データが無効なとき' do
      it '名前がなければ無効である' do
        certificate = build(:certificate, name: nil)
        certificate.valid?
        expect(certificate.errors[:name]).to include('を入力してください')
      end
      
      it '名前が51文字以上なら無効である' do
        certificate = build(:certificate, name: 'a' * 51)
        certificate.valid?
        expect(certificate.errors[:name]).to include('は50文字以内で入力してください')
      end
      
      it '名前が重複しているなら無効である' do
        certificate = create(:certificate, name: 'ITパスポート')
        expect(certificate).to be_valid
        another_certificate = build(:certificate, name: 'ITパスポート')
        another_certificate.valid?
        expect(another_certificate.errors[:name]).to include('はすでに存在します')
      end
    end
  end
end
