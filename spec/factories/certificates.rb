FactoryBot.define do
  factory :certificate do
    trait :a do
      name { '基本情報技術者' }
    end
    trait :b do
      name { 'データベーススペシャリスト' }
    end
    trait :c do
      name { 'ITストラテジスト' }
    end
  end
end
