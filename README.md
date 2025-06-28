# アプリケーション名

## TaskBoard

# アプリケーションの概要

- タスクを視覚的に管理することができます。
- 個人でもチームでもタスクを管理することができます。
- チームでタスク管理をする際はコメントをすることができます。

# URL

[TaskBoard](https://taskboard-41904.onrender.com)

# テスト用アカウント

- Basic認証: admin
- Basic認証パスワード: 2222

# 利用方法

## ユーザー登録

1. ページのヘッダーからユーザー新規登録を行います。

## チーム作成

1. トップページの左側にあるサイドバーの「チーム」へアクセスします。

2. チームの新規作成ページより共同してタスクを管理するチームを作成します。

3. タスクを共同管理するメンバーをチームへ追加できます。（メールアドレスにより追加）

## タスク作成

1. トップページの「タスク作成」ボタンから新たなタスクを作成します。

2. 作成する際は、「タスク名」、「期限」、「優先度」、「状態」、「タスク内容」を入力します。

3. 作成したタスクは「今日のタスク」、「今週のタスク」、「すべてのタスク」、「完了したタスク」のいずれかに表示されます。

4. 完了したタスクのチェックボックスにチェックを入れることでタスクが完了します。

## コメント投稿

1. タスクを共同管理するチームメンバーは同一チーム内のタスクに対してコメントできます。

# アプリケーションを作成した背景

### 現在勤務している職場において、タスク管理は紙の付箋又はパソコンの付箋機能により行っている実態があります。<br>紙の付箋による管理だと紛失することでタスク管理ができなくなります。<br>また、パソコンの付箋機能による管理だとチームでの管理はできず、ソート機能が備わっていない等の視覚的な課題があります。<br>タスクはチームにより漏れがないよう管理すること、優先度に応じて効率的に管理すること、視覚的に状態が把握しやすいよう管理することが重要であると考え、タスクをチームで効率的に、かつ、視覚的に管理したいという思いから、タスク管理アプリケーションを開発することにしました。

# 洗い出した要件
[要件定義したシート](https://docs.google.com/spreadsheets/d/1XfjEgqoSHKUY6Mj4nO5NyrWz4qApYOyLxPKVFW2A7T8/edit?usp=sharing)

# 実装した機能についての画像やGIFおよびその説明

- [ユーザー登録機能](https://gyazo.com/fea58d7aca6bc523214b1e4abd512e1a)
- [チーム作成機能](https://gyazo.com/3a252a3bfbb12a3caa8a0140319ef2a6)
- [タスク作成機能](https://gyazo.com/26118adea875604fce9d81c04f555ea2)
- [コメント投稿機能](https://gyazo.com/e1d22a5a337648e76a119707862bb09c)

# 実装予定の機能

- outlook等に連携し、タスク完了や登録の通知機能を実装予定です。

# データベース設計
[ER図](https://drive.google.com/file/d/1jd1YEJij85STzJwn78GEOmBhsqLzcxOL/view?usp=sharing)

# 画面遷移図
[画面遷移図](https://drive.google.com/file/d/1K5YG5PcNvKz4xtuR4CYomrOQk56Kkx2Q/view?usp=sharing)

# 開発環境

- フロントエンド：HTML,CSS, JavaScript
- バックエンド  ：Ruby on Rails

# ローカルでの動作方法

% git clone https://github.com/sugimoto519/taskboard-41904

% cd taskboard-41904

% bundle install

% yarn install

% rails db:create

% rails db:migrate

# 工夫したポイント

- タスクの表示順を期限が迫っているものから上位表示としました。
- 期限が切れたタスクは視覚的に分かるようにするため、注意喚起できる色へと変色するよう実装しました。
- 複数人での管理が必要と考え,チームでのタスク管理としました。

# テーブル設計

## usersテーブル

| Column   | Type   |Options      |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false, unique: true |
| password | string | null: false |

### Association

- has_many :tasks
- has_many :teams
- has_many :comments

## teamテーブル

| Column      | Type       |Options                         |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false, unique: true      |
| description | string     | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many   :team_users, dependent: :destroy
- has_many   :members, through: :team_users, source: :user
- has_many   :tasks, dependent: :destroy

## taskテーブル

| Column        | Type       |Options      |
| ------------- | ---------- | ----------- |
| task_name     | string     | null: false |
| deadline      | datetime   | null: false |
| priority_id   | integer    | null: false |
| status_id     | integer    | null: false |
| content       | text       | null: false |
| position      | integer    |             |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :priority
- belongs_to :status
- belongs_to :team
- has_many :comments, dependent: :destroy

※ priority / status にはActiveHashを使用

## team_usersテーブル（中間テーブル）
| Column        | Type       |Options                         |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| team          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :team

## commentテーブル

| Column  | Type       |Options                         |
| ------- | ---------- | ------------------------------ |
| content | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| task    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :task