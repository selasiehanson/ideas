class Project < ActiveRecord::Base
  attr_accessible :description, :title, :project_category_id
  
  validates :title, presence: true
  validates :user_id, presence: true
  validates :project_category_id, presence: true
  
  belongs_to :user
  belongs_to :project_category
  has_many :notes
  has_many :tasks
  default_scope order: 'projects.created_at DESC'

  def as_json(options = {})
  	format = {
  		:include => :project_category
  	}

  	super format
  end
end
