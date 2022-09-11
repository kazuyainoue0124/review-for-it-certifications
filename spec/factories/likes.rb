FactoryBot.define do
  factory :like do
    trait :a do
      user_id { 1 }
      post_id { 1 }
    end
    # trait :b do
    # user_id { 2 }
    # post_id { 2 }
    # end
    # trait :c do
    # user_id { 3 }
    # post_id { 3 }
    # end
  end
end
