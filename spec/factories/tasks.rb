FactoryBot.define do
  factory :task do
    task_name { Faker::Commerce.product_name }
    deadline { Faker::Time.between(from: DateTime.now, to: DateTime.now + 30.days) }
    priority_id { Faker::Number.between(from: 2, to: 4) }
    status_id { Faker::Number.between(from: 2, to: 4) }
    content { Faker::Lorem.sentence }
    association :user
    association :team
  end
end
