class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team

  enum role: { member: 0, admin: 1 } #役割をenumで定義

  validates :user_id, uniqueness: { scope: :team_id, message: "は既にこのチームに参加しています" }
end
