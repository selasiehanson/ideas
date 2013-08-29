class Note < Input
  before_validation(:on => :create) do
  	self.status = :note
  end
end
