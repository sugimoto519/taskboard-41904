class AddTeamIdToTasks < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:tasks, :team_id)
      add_reference :tasks, :team, null: true, foreign_key: true
    end
  end
end
