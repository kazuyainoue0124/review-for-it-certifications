FactoryBot.define do
  factory :relationship do
    trait :a do
      follower_id { create(:user, :a).id }
      followed_id { create(:user, :a).id }
    end
    # trait :b do
    #   follower_id { 1 }
    #   followed_id { 2 }
    # end
    
    # trait :c do
    #   follower_id { 1 }
    #   followed_id { 2 }
    # end
  end
end
