require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe '資格モデルのバリデーションチェック' do
    let(:certificate) { create(:certificate, :a) }
    # name
    let(:certificate_with_50_characters_name) { create(:certificate, :a, name: 'a' * 50) }
    let(:certificate_without_name) { build(:certificate, :a, name: nil) }
    let(:certificate_with_51_characters_name) { build(:certificate, :a, name: 'a' * 51) }
    let(:certificate_with_duplicate_name1) { create(:certificate, :a) }
    let(:certificate_with_duplicate_name2) { build(:certificate, :a) }

    context '資格データが有効なとき' do
      it '名前が存在するなら有効である' do
        expect(certificate).to be_valid
      end
      it '名前が50文字以下なら有効である' do
        expect(certificate_with_50_characters_name).to be_valid
      end
    end

    context '資格データが無効なとき' do
      it '名前がなければ無効である' do
        certificate_without_name.valid?
        expect(certificate_without_name.errors[:name]).to include("can't be blank")
      end

      it '名前が51文字以上なら無効である' do
        certificate_with_51_characters_name.valid?
        expect(certificate_with_51_characters_name.errors[:name]).to include('is too long (maximum is 50 characters)')
      end

      it '名前が重複しているなら無効である' do
        expect(certificate_with_duplicate_name1).to be_valid
        certificate_with_duplicate_name2.valid?
        expect(certificate_with_duplicate_name2.errors[:name]).to include('has already been taken')
      end

    end

  end

end
