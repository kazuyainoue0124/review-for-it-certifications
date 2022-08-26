Position.create!(
  name: 'プログラマー'
)
Position.create!(
  name: 'システムエンジニア'
)
Position.create!(
  name: 'Webエンジニア'
)
Position.create!(
  name: '社内SE'
)
Position.create!(
  name: 'サーバーエンジニア'
)
Position.create!(
  name: 'ネットワークエンジニア'
)
Position.create!(
  name: 'データベースエンジニア'
)
Position.create!(
  name: 'セキュリティエンジニア'
)
Position.create!(
  name: 'インフラエンジニア'
)
Position.create!(
  name: 'プロジェクトリーダー'
)
Position.create!(
  name: 'プロジェクトマネージャー'
)
Position.create!(
  name: 'ITコンサルタント'
)
Position.create!(
  name: 'アーキテクト'
)

Certificate.create!(
  name: 'ITパスポート'
)
Certificate.create!(
  name: '基本情報技術者'
)
Certificate.create!(
  name: '応用情報技術者'
)
Certificate.create!(
  name: '情報処理安全保障支援士'
)
Certificate.create!(
  name: 'データベーススペシャリスト'
)
Certificate.create!(
  name: 'ネットワークスペシャリスト'
)
Certificate.create!(
  name: 'エンベデッドスペシャリスト'
)
Certificate.create!(
  name: 'ITストラテジスト'
)
Certificate.create!(
  name: 'システムアーキテクト'
)
Certificate.create!(
  name: 'LPIC'
)
Certificate.create!(
  name: '簿記2級'
)
Certificate.create!(
  name: '簿記3級'
)
Certificate.create!(
  name: 'PMP'
)

10.times do |n|
  User.create!(
    name: "サンプルユーザー#{n + 1}",
    email: "user#{n + 1}@sample.com",
    password: 'password',
    password_confirmation: 'password',
    position_id: n + 1,
    job_change_count: "#{n + 1}回",
    salary_before_two_years: '351~400万円',
    salary_before_one_years: '401~450万円',
    current_salary: '451~500万円',
    certificate_id: n + 1,
    profile: "こんにちは！サンプルユーザー#{n + 1}です！"
  )
end
