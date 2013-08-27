class Note < Input
  before_validation(:on => :create) do
  	self.status = :note
  end
end

# attr_accessible :content
# validates :content, presence: true
# validates :project_id, presence: true
# belongs_to :project
# has_one :task
