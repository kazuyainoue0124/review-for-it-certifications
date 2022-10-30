require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーモデルのバリデーションチェック' do

    context 'ユーザーデータが有効なとき' do
      it '名前、メールアドレス、パスワード、パスワード確認があれば有効である' do
        user = create(:user, name: '山田太郎', email: 'taro@gmail.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end
      
      it '名前が15文字であれば有効である' do
        user = create(:user, name: 'a' * 15, email: 'taro@gmail.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end
      
      it 'パスワードが6文字であれば有効である' do
        user = create(:user, name: '山田太郎', email: 'taro@gmail.com', password: 'a' * 6, password_confirmation: 'a' * 6)
        expect(user).to be_valid
      end
      
      it 'パスワードが10文字であれば有効である' do
        user = create(:user, name: '山田太郎', email: 'taro@gmail.com', password: 'a' * 10, password_confirmation: 'a' * 10)
        expect(user).to be_valid
      end
    end
    
    context 'ユーザーデータが無効なとき' do
      it '名前がなければ無効である' do
        user = build(:user, name: nil, email: 'taro@gmail.com', password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:name]).to include('を入力してください')
      end
      
      it '名前が16文字以上であれば無効である' do
        user = build(:user, name: 'a' * 16, email: 'taro@gmail.com', password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:name]).to include('は15文字以内で入力してください')
      end
      
      it 'メールアドレスがなければ無効である' do
        user = build(:user, name: '山田太郎', email: nil, password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:email]).to include('を入力してください')
      end
      
      it 'メールアドレスが正規表現に沿っていなければ無効である' do
        user1 = build(:user, name: '山田太郎', email: 'taro@gmail,com', password: 'password', password_confirmation: 'password')
        user2 = build(:user, name: '山田太郎', email: 'taro_at_foo.org', password: 'password', password_confirmation: 'password')
        user3 = build(:user, name: '山田太郎', email: 'taro.name@example.', password: 'password', password_confirmation: 'password')
        user4 = build(:user, name: '山田太郎', email: 'taro@bar_baz.com', password: 'password', password_confirmation: 'password')
        user5 = build(:user, name: '山田太郎', email: 'taro@bar+baz.com', password: 'password', password_confirmation: 'password')
        expect(user1).not_to be_valid
        expect(user2).not_to be_valid
        expect(user3).not_to be_valid
        expect(user4).not_to be_valid
        expect(user5).not_to be_valid
      end

      it '重複したメールアドレスであれば無効である' do
        user = create(:user, name: '山田太郎', email: 'taro@gmail.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
        another_user = build(:user, name: '鈴木太郎', email: 'taro@gmail.com', password: 'password', password_confirmation: 'password')
        another_user.valid?
        expect(another_user.errors[:email]).to include('はすでに存在します')
      end
      
      it 'パスワードがなければ無効である' do
        user = build(:user, name: '山田太郎', email: 'taro@gmail.com', password: nil, password_confirmation: 'password')
        user.valid?
        expect(user.errors[:password]).to include('を入力してください')
      end
      
      it 'パスワードが5文字以下であれば無効である' do
        user = build(:user, name: '山田太郎', email: 'taro@gmail.com', password: 'a' * 5, password_confirmation: 'a' * 5)
        user.valid?
        expect(user.errors[:password]).to include('は6文字以上で入力してください')
      end
      
      it 'パスワードが11文字以上であれば無効である' do
        user = build(:user, name: '山田太郎', email: 'taro@gmail.com', password: 'a' * 11, password_confirmation: 'a' * 11)
        user.valid?
        expect(user.errors[:password]).to include('は10文字以内で入力してください')
      end
      
      it 'パスワードとパスワード確認が不一致であれば無効である' do
        user = build(:user, name: '山田太郎', email: 'taro@gmail.com', password: 'password', password_confirmation: 'hassworr')
        user.valid?
        expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
      end
    end
  end
end
