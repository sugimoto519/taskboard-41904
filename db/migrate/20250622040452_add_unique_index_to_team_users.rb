class AddUniqueIndexToTeamUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :team_users, [:user_id, :team_id], unique: true
  end
end
