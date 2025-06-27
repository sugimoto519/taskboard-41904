FactoryBot.define do
  factory :team_user do
    association :user
    association :team
  end
end
