# README

# テーブル設計

## usersテーブル

| Column   | Type   |Options      |
| -------- | ------ | ----------- |
| name     | string | null: false |
| email    | string | null: false, unique: true |
| password | string | null: false |

### Association

- has_many :tasks
- has_many :comments

## taskテーブル

| Column        | Type       |Options      |
| ------------- | ---------- | ----------- |
| task_name     | string     | null: false |
| deadline      | datetime   | null: false |
| priority      | integer    | null: false |
| status        | integer    | null: false |
| content       | text       | null: false |
| position      | integer    |             |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

※ priority / status は ActiveHash を使用予定
※ Taskモデルに 'belongs_to_active_hash :priority', 'belongs_to_active_hash :status' を書く

## user_tasksテーブル（中間テーブル）
| Column        | Type       |Options      |
| ------------- | ---------- | ----------- |
| user          | references | null: false, foreign_key: true |
| task          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :task

## commentテーブル

| Column  | Type       |Options      |
| ------- | ---------- | ----------- |
| comment | text       | null: false |
| user    | references | null: false, foreign_key: true |
| task    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :task