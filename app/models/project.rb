class Project < ActiveRecord::Base
  attr_accessible :description, :title

  validates :title, presence: true
  validates :user_id, presence: true
  belongs_to :user
  has_many :notes
  default_scope order: 'projects.created_at DESC'
end
