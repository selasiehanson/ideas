class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :project_id

      t.timestamps
    end

    add_index :notes, [:project_id]
  end
end
