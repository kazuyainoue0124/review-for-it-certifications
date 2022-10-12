FactoryBot.define do
  factory :user do
    trait :a do
      name { 'サンプルユーザー1' }
      sequence(:email) { |n| "user#{n}@example.com" }
      password { 'useruser' }
      password_confirmation { 'useruser' }
      # certificate_id { 1 }
    end
    trait :b do
      name { 'サンプルユーザー2' }
      email { 'user2@example.com' }
      password { 'useruser' }
      password_confirmation { 'useruser' }
      # certificate_id { 2 }
    end
    
    trait :c do
      name { 'サンプルユーザー3' }
      email { 'user3@example.com' }
      password { 'useruser' }
      password_confirmation { 'useruser' }
      # certificate_id { 3 }
    end
  end
end
