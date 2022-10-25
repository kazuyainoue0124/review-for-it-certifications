# 「シカクチコミ」 - IT資格のクチコミアプリ -
-  収入アップにつながる資格を知りたい
- 自分のキャリアにとってどの資格を取るのが良いかわからない、、、
- そもそもこの資格って取る価値あるのかなぁ……？

こういった悩みを抱えるSIerの若手社員をターゲットに、IT資格に特化したクチコミサイト「シカクチコミ」を作りました！

## 使用技術一覧
本ポートフォリオで用いた技術を列挙します。
### フロントエンド
- HTML/CSS
- JavaScript
- jQuery

### バックエンド
- Ruby3.1.2
- Ruby on Rails6.1.6
- MySQL8.0

### インフラ
- AWS(VPC/RDS/ALB/ACM/Route53/Fargate/ECR/ECS)
- Terraform([別リポジトリ](https://github.com/kazuyainoue0124/infrastructure-portfolio)に記載)

### テスト
- RSpec

### CI/CD
- CircleCI

### バージョン管理
- Git/GitHub

### 開発環境
- VScode
- Docker

## 機能一覧
本ポートフォリオの機能を列挙します。
- ユーザー新規登録/ログイン
- プロフィール編集
- 新規投稿/投稿編集
- 投稿一覧
- 投稿詳細
- いいね！
- ブックマーク
- フォロー/フォロー解除
- フォロー一覧/フォロワー一覧
- 投稿検索/ユーザー検索
- 最も役に立った資格ランキング/フォロワー数ランキング

## ER図
![ER図-Portfolio(ER図) drawio](https://user-images.githubusercontent.com/88877589/195987620-9f1c2738-cd92-47c5-afab-30c0f5b92f00.png)

## インフラ構成図
![インフラ構成図 drawio](https://user-images.githubusercontent.com/88877589/195987934-9c197905-7b34-48ea-969b-5475fe853197.png)

## 画面設計書(構想時点で簡易的に作成したため、実際のアプリとは一致していません)
![IT資格の口コミアプリ](https://user-images.githubusercontent.com/88877589/196896544-e78124f8-8420-4e70-89cb-9ed9e8bacc9b.png)

## ポートフォリオ作成の背景・動機
「SIer/SESの社員には資格について悩んでる人が多い」と感じたのがきっかけです。<br>
仲の良い同僚と話すときによく挙がるテーマとして「資格取得」がありました。<br>
よく出てくる意見は大きく以下の3つです。

- 資格を取るのはいいけど、今の自分にとってどれを取ればいいのかわからない
- どうせ取るなら意味のある資格を取りたい
- 資格なんてただの暗記だから取る意義を感じない

一方でQiitaにはSIer/SES社員の発信者は少なく、IT資格に関する投稿をしているのは理系の大学生が中心です。<br>
そのため「その資格が単価アップに役立つのか？」「自分のキャリアにとってどの資格を取るのがいいか？」といった実務に直結する情報は数が多くありません。<br>
こういった課題の解消をイメージしながらであれば、より前向きにポートフォリオ作成に取り組めるのではないかと思い、「IT資格」をテーマとして選択しました。
