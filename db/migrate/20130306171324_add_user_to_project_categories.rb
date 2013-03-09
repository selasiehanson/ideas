class AddUserToProjectCategories < ActiveRecord::Migration
  def change
  	add_column :project_categories, :user_id, :integer
  end
end
