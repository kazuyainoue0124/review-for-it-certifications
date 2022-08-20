FactoryBot.define do
  factory :user do
    trait :a do
      name { 'サンプルユーザー1' }
      sequence(:email) { |n| "user#{n}@example.com" }
      password { 'useruser' }
      password_confirmation { 'useruser' }
    end
    trait :b do
      name { 'サンプルユーザー2' }
      email { 'user2@example.com' }
      password { 'useruser' }
      password_confirmation { 'useruser' }
    end
    trait :c do
      name { 'サンプルユーザー3' }
      email { 'user3@example.com' }
      password { 'useruser' }
      password_confirmation { 'useruser' }
    end
  end
end
