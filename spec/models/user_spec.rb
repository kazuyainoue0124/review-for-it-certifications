require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーモデルのバリデーションチェック' do
    let(:user) { create(:user, :a) }
    # name
    let(:user_with_15_characters_name) { create(:user, :a, name: 'a' * 15) }
    let(:user_with_6_characters_password) { create(:user, :a, password: 'a' * 6, password_confirmation: 'a' * 6) }
    let(:user_with_10_characters_password) { create(:user, :a, password: 'a' * 10, password_confirmation: 'a' * 10) }
    let(:user_without_name) { build(:user, :a, name: nil) }
    # email
    let(:user_without_email) { build(:user, :a, email: nil) }
    let(:user_with_irregular_expression_email1) { build(:user, :a, email: 'user@example,com') }
    let(:user_with_irregular_expression_email2) { build(:user, :a, email: 'user_at_foo.org') }
    let(:user_with_irregular_expression_email3) { build(:user, :a, email: 'user.name@example.') }
    let(:user_with_irregular_expression_email4) { build(:user, :a, email: 'foo@bar_baz.com') }
    let(:user_with_irregular_expression_email5) { build(:user, :a, email: 'foo@bar+baz.com') }
    let(:user_with_duplicate_email1) { create(:user, :a, email: 'user000@example.com') }
    let(:user_with_duplicate_email2) { build(:user, :a, email: 'user000@example.com') }
    # password
    let(:user_without_password) { build(:user, :a, password: nil) }
    let(:user_with_5_characters_password) { build(:user, :a, password: 'a' * 5) }
    let(:user_with_11_characters_password) { build(:user, :a, password: 'a' * 11) }
    let(:user_with_password_correspond_not_to_password_confirmation) { build(:user, :a, password: 'foobar', password_confirmation: 'barfoo') }
    let(:user_with_16_characters_name) { build(:user, :a, name: 'a' * 16) }

    context 'ユーザーデータが有効なとき' do
      it '名前、メールアドレス、パスワード、パスワード確認があれば有効である' do
        expect(user).to be_valid
      end

      it '名前が15文字であれば有効である' do
        expect(user_with_15_characters_name).to be_valid
      end

      it 'パスワードが6文字であれば有効である' do
        expect(user_with_6_characters_password).to be_valid
      end

      it 'パスワードが10文字であれば有効である' do
        expect(user_with_10_characters_password).to be_valid
      end
    end

    context 'ユーザーデータが無効なとき' do
      it '名前がなければ無効である' do
        user_without_name.valid?
        expect(user_without_name.errors[:name]).to include('を入力してください')
      end

      it '名前が16文字以上であれば無効である' do
        user_with_16_characters_name.valid?
        expect(user_with_16_characters_name.errors[:name]).to include('は15文字以内で入力してください')
      end

      it 'メールアドレスがなければ無効である' do
        user_without_email.valid?
        expect(user_without_email.errors[:email]).to include('を入力してください')
      end

      it 'メールアドレスが正規表現に沿っていなければ無効である' do
        expect(user_with_irregular_expression_email1).not_to be_valid
        expect(user_with_irregular_expression_email2).not_to be_valid
        expect(user_with_irregular_expression_email3).not_to be_valid
        expect(user_with_irregular_expression_email4).not_to be_valid
        expect(user_with_irregular_expression_email5).not_to be_valid
      end

      it '重複したメールアドレスであれば無効である' do
        expect(user_with_duplicate_email1).to be_valid
        user_with_duplicate_email2.valid?
        expect(user_with_duplicate_email2.errors[:email]).to include('はすでに存在します')
      end

      it 'パスワードがなければ無効である' do
        user_without_password.valid?
        expect(user_without_password.errors[:password]).to include('を入力してください')
      end

      it 'パスワードが5文字以下であれば無効である' do
        user_with_5_characters_password.valid?
        expect(user_with_5_characters_password.errors[:password]).to include('は6文字以上で入力してください')
      end

      it 'パスワードが11文字以上であれば無効である' do
        user_with_11_characters_password.valid?
        expect(user_with_11_characters_password.errors[:password]).to include('は10文字以内で入力してください')
      end

      it 'パスワードとパスワード確認が不一致であれば無効である' do
        user_with_password_correspond_not_to_password_confirmation.valid?
        expect(user_with_password_correspond_not_to_password_confirmation.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end
    end
  end
end
