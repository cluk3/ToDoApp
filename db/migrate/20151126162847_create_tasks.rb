class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :owner, index: true, foreign_key: true
      t.string :value
      t.boolean :completed
      t.string :category
      t.date :overdue
      t.references :assignee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
