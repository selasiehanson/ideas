class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :note
      t.integer :status
      t.text :content

      t.timestamps
    end
    add_index :tasks, :note_id
  end
end
