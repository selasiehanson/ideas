class Task < Input
  
  scope :find_users_tasks_by_status, lambda{ |status, user, project|
  	{
  		:include => :project,
      :order => "tasks.created_at DESC",
  		:conditions => [ "tasks.status = :status AND projects.user_id = :user_id AND tasks.project_id = :project_id" , 
        { :status => Task::STATUS[status], :user_id => user.id , :project_id => project.id} ]
  	}
  }
  
  def change_status()
    out = nil
    if self.status == :pending
      self.status = :started
    elsif self.status == :started
      self.status = :completed
    else
    end 
    # self.save
  end
end
