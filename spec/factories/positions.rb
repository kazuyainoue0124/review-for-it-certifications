FactoryBot.define do
  factory :position do
    trait :a do
      name { 'システムエンジニア' }
    end
    trait :b do
      name { 'プロジェクトマネージャー' }
    end
    trait :c do
      name { 'CTO' }
    end
  end
end
