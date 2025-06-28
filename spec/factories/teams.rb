FactoryBot.define do
  factory :team do
    # sequenceを使って、テスト実行時に一意なチーム名を保証する
    sequence(:name) { |n| "#{Faker::Team.name} #{n}" }
    description { Faker::Lorem.sentence }

    # チームは必ず作成者(user)を持つ
    association :user

    # 「メンバーがいるチーム」を簡単に作成するためのtrait
    trait :with_members do
      # transientで一時的な変数を定義。ファクトリ呼び出し時に上書きできる
      transient do
        members_count { 3 } # デフォルトで3人のメンバーを作成
      end

      # after(:create)で、チーム作成後に関連レコードを作成する
      after(:create) do |team, evaluator|
        # create_listで指定した数のUser(メンバー)を作成し、チームに追加する
        team.members << create_list(:user, evaluator.members_count)
      end
    end
  end
end
