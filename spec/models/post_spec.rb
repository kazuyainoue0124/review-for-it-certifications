require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'ポストモデルのバリデーションチェック' do
    let(:user) { create(:user, :'山田太郎') }
    let(:certificate) { create(:certificate, :'ITパスポート') }
    context 'ポストデータが有効なとき' do
      it 'ユーザーID(user_id)、タイトル(title)、資格ID(certificate_id)、学習期間(study_period)、実務に役立った度(valuable_score)、おすすめ度(recommend_score)が存在すれば有効である' do
        post = create(:post, user_id: user.id, title: 'ITパスポートに合格しました!', certificate_id: certificate.id, study_period: '~1ヶ月',
                            valuable_score: 'すごく役に立った', recommend_score: 'すごくおすすめ', how_to_study: nil, how_change: nil,
                            recommended_person: nil, comment: nil)
        expect(post).to be_valid
      end

      it 'タイトルが50文字以内であれば有効である' do
        post = create(:post, user_id: user.id, title: 'a' * 50, certificate_id: certificate.id, study_period: '~1ヶ月',
                            valuable_score: 'すごく役に立った', recommend_score: 'すごくおすすめ')
        expect(post).to be_valid
      end
    end

    context 'ポストデータが無効なとき' do
      it 'ユーザーIDがなければ無効である' do
        post = build(:post, user_id: nil, title: 'ITパスポートに合格しました!', certificate_id: certificate.id, study_period: '~1ヶ月',
                            valuable_score: 'すごく役に立った', recommend_score: 'すごくおすすめ')
        post.valid?
        expect(post.errors[:user_id]).to include('を入力してください')
      end

      it 'タイトルがなければ無効である' do
        post = build(:post, user_id: user.id, title: nil, certificate_id: certificate.id, study_period: '~1ヶ月',
                            valuable_score: 'すごく役に立った', recommend_score: 'すごくおすすめ')
        post.valid?
        expect(post.errors[:title]).to include('を入力してください')
      end

      it 'タイトルが51文字以上であれば無効である' do
        post = build(:post, user_id: user.id, title: 'a' * 51, certificate_id: certificate.id, study_period: '~1ヶ月',
                            valuable_score: 'すごく役に立った', recommend_score: 'すごくおすすめ')
        post.valid?
        expect(post.errors[:title]).to include('は50文字以内で入力してください')
      end

      it '資格IDがなければ無効である' do
        post = build(:post, user_id: user.id, title: 'ITパスポートに合格しました!', certificate_id: nil, study_period: '~1ヶ月',
                            valuable_score: 'すごく役に立った', recommend_score: 'すごくおすすめ')
        post.valid?
        expect(post.errors[:certificate_id]).to include('を入力してください')
      end

      it '学習期間(study_period)がなければ無効である' do
        post = build(:post, user_id: user.id, title: 'ITパスポートに合格しました!', certificate_id: certificate.id, study_period: nil,
                            valuable_score: 'すごく役に立った', recommend_score: 'すごくおすすめ')
        post.valid?
        expect(post.errors[:study_period]).to include('を入力してください')
      end

      it '実務に役立った度(valuable_score)がなければ無効である' do
        post = build(:post, user_id: user.id, title: 'ITパスポートに合格しました!', certificate_id: certificate.id, study_period: '~1ヶ月',
                            valuable_score: nil, recommend_score: 'すごくおすすめ')
        post.valid?
        expect(post.errors[:valuable_score]).to include('を入力してください')
      end

      it 'おすすめ度(recommend_score)がなければ無効である' do
        post = build(:post, user_id: user.id, title: 'ITパスポートに合格しました!', certificate_id: certificate.id, study_period: '~1ヶ月',
                            valuable_score: 'すごく役に立った', recommend_score: nil)
        post.valid?
        expect(post.errors[:recommend_score]).to include('を入力してください')
      end
    end
  end
end
