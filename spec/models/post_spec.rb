require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "ポストモデルのバリデーションチェック" do
    let!(:certificate) { create(:certificate, :a) }
    let!(:certificate) { create(:certificate, :b) }
    let!(:certificate) { create(:certificate, :c) }
    let!(:position) { create(:position, :a) }
    let!(:position) { create(:position, :b) }
    let!(:position) { create(:position, :c) }
    let!(:user) { create(:user, :a) }
    let!(:user) { create(:user, :b) }
    let!(:user) { create(:user, :c) }
    let(:post) { create(:post) }
    let(:post_with_only_necessary_columns) { build(:post, how_to_study: nil, how_change: nil, recommended_person: nil )}
    # user_id
    let(:post_without_user_id) { build(:post, user_id: nil) }
    # title
    let(:post_without_title) { build(:post, title: nil) }
    let(:post_with_50_characters_title) { build(:post, title: 'a' * 50) }
    let(:post_with_51_characters_title) { build(:post, title: 'a' * 51) }
    # certificate_id
    let(:post_without_certificate_id) { build(:post, certificate_id: nil) }
    # study_period
    let(:post_without_study_period) { build(:post, study_period: nil) }
    # how_to_study
    # -- nothing
    # valuable_score
    let(:post_without_valuable_score) { build(:post, valuable_score: nil )}
    # how_change
    # -- nothing
    # recommend_score
    let(:post_without_recommend_score) { build(:post, recommend_score: nil )}
    # recommended_person
    # -- nothing
    # comment
    # -- nothing

    context 'ポストデータが有効なとき' do
      it 'ユーザーID(user_id)、タイトル(title)、資格ID(certificate_id)、学習期間(study_period)、実務に役立った度(valuable_score)、おすすめ度(recommend_score)が存在すれば有効である' do
        expect(post_with_only_necessary_columns).to be_valid
      end

      it 'タイトルが50文字以内であれば有効である' do
        expect(post_with_50_characters_title).to be_valid
      end
    end

    context 'ポストデータが無効なとき' do
      it 'ユーザーIDがなければ無効である' do
        post_without_user_id.valid?
        expect(post_without_user_id.errors[:user_id]).to include("can't be blank")
      end

      it 'タイトルがなければ無効である' do
        post_without_title.valid?
        expect(post_without_title.errors[:title]).to include("can't be blank")
      end

      it 'タイトルが51文字以上であれば無効である' do
        post_with_51_characters_title.valid?
        expect(post_with_51_characters_title.errors[:title]).to include('is too long (maximum is 50 characters)')
      end

      it '資格IDがなければ無効である' do
        post_without_certificate_id.valid?
        expect(post_without_certificate_id.errors[:certificate_id]).to include("can't be blank")
      end

      it '学習期間がなければ無効である' do
        post_without_study_period.valid?
        expect(post_without_study_period.errors[:study_period]).to include("can't be blank")
      end

      it '実務に役立った度がなければ無効である' do
        post_without_valuable_score.valid?
        expect(post_without_valuable_score.errors[:valuable_score]).to include("can't be blank")
      end

      it 'おすすめ度がなければ無効である' do
        post_without_recommend_score.valid?
        expect(post_without_recommend_score.errors[:recommend_score]).to include("can't be blank")
      end
    end
  end
end
