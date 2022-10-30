FactoryBot.define do
  factory :user do
    
    trait :'山田太郎' do
      name { '山田太郎' }
      email { 'yamada@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

    trait :'佐藤翼' do
      name { '佐藤翼' }
      email { 'sato@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

    trait :'加藤健斗' do
      name { '加藤健斗' }
      email { 'kato@gmail.com' }
      password { 'password' }
      password_confirmation { 'password' }
    end

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
