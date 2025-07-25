class CreateTeamUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :team_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :role, default: 0, null: false

      t.timestamps
    end
  end
end
