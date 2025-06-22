class Task < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :priority
  belongs_to :status
  belongs_to :team
  has_many :comments, dependent: :destroy

  validates :task_name, :deadline, :content, presence: true

  validates :priority_id, numericality: { other_than: 1, message: "can't be blank"}
  validates :status_id, numericality: { other_than: 1, message: "can't be blank" }
end
