class Team < ApplicationRecord
  belongs_to :user
  has_many :team_users, dependent: :destroy
  has_many :members, through: :team_users, source: :user
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
  validates :user_id, presence: true
end
