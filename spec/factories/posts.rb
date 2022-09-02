FactoryBot.define do
  factory :post do
    user_id { 1 }
    title { '基本情報技術者の資格を取りました!' }
    certificate_id { 1 }
    study_period { '~1ヶ月' }
    how_to_study { '最初の1週間で参考書を読み切って、残りの3週間はひたすら過去問を解いていました！' }
    valuable_score { 'すごく役に立った' }
    how_change { 'コンピュータそのものへの理解が深まったため、IT企業で働く上での土台が築けたと思います！その一方で、テスト対策に偏ってしまい、本質的な勉強にならなかったとも感じています！' }
    recommend_score { 'すごくおすすめ' }
    recommended_person { '未経験からIT業界へ転職してきた人にはとてもおすすめです。この資格を通じてコンピュータサイエンスの基礎について理解を深められます！' }
    comment { 'テスト対策に特化せず、本質的な理解を追求すべき資格なので、焦らずにひとつずつ学んでいきましょう！' }
    # trait :a do
    # end
    # trait :b do
    #   name { 'サンプルユーザー2' }
    #   email { 'user2@example.com' }
    #   password { 'useruser' }
    #   password_confirmation { 'useruser' }
    # end

    # trait :c do
    #   name { 'サンプルユーザー3' }
    #   email { 'user3@example.com' }
    #   password { 'useruser' }
    #   password_confirmation { 'useruser' }
    # end
  end
end
