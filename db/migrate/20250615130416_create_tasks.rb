class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :task_name, null: false
      t.datetime :deadline, null: false
      t.integer :priority, null: false
      t.integer :status, null: false
      t.text :content, null: false
      t.integer :position
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
