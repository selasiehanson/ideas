class Note < Input
	belongs_to :project
  before_validation(:on => :create) do
  	self.status = :note
  end
end
