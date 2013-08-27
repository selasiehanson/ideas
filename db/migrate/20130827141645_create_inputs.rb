class CreateInputs < ActiveRecord::Migration
  def change
    create_table :inputs do |t|
      t.text :content
      t.references :project
      t.string :type
      t.integer :status
      t.timestamps
    end
    add_index :inputs, :project_id
  end
end
