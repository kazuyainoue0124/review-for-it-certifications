FactoryBot.define do
  factory :user do
    trait :a do
      name { 'サンプルユーザー1' }
      sequence(:email) { |n| "user#{n}@example.com" }
      password { 'useruser' }
      password_confirmation { 'useruser' }
      # position_id { 1 }
      # job_change_count { "3回" }
      # salary_before_two_years { "301~350万円"}
      # salary_before_one_years { "301~350万円"}
      # current_salary { "401~450万円"}
      # certificate_id { 1 }
      # profile { "Hello, world!" }
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
