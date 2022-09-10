FactoryBot.define do
  factory :bookmark do
    # let!(:position) { create(:position, :a) }
    # let!(:certificate) { create(:certificate, :a) }
    # let!(:user) { create(:user, :a) }
    # let(:post) { create(:post) }
    trait :a do
      user_id { 1 }
      post_id { 1 }
    end
    # trait :b do
    #   user_id { create(:user, :b).id }
    #   post_id { create(:post, :a).id }
    # end
    # trait :c do
    #   user_id { create(:user, :c).id }
    #   post_id { create(:post, :a).id }
    # end
  end
end
