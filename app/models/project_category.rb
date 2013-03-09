class ProjectCategory < ActiveRecord::Base
  attr_accessible :description, :name
  validates :name, presence: true
  validates :user_id, presence: true

  has_many :projects
  belongs_to :user
  default_scope order: 'project_categories.created_at DESC'
end
