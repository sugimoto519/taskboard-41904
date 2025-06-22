class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :teams
  has_many :team_users, dependent: :destroy
  has_many :participating_teams, through: :team_users, source: :team 
  has_many :comments, dependent: :destroy
         
end
