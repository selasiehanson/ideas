class Note < ActiveRecord::Base
	attr_accessible :content
  validates :content, presence: true
  validates :project_id, presence: true
  belongs_to :project
  has_one :task
end
