class Task < Input

  belongs_to :project
    
  scope :find_users_tasks_by_status, lambda{ |status, user, project|
  	{
  		:include => :project,
      :order => "inputs.created_at DESC",
  		:conditions => [ "status = :status AND projects.user_id = :user_id AND project_id = :project_id" , 
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

  # STATUS = { pending: 1,  started: 2, completed: 3  }.freeze

  # attr_accessible :status, :content, :note, :project

  # belongs_to :note
  # belongs_to :project

  # validates :content, presence: true
  # validates :note_id, presence: true
  # validates :status, :presence => true, :inclusion => { in: STATUS }
  # validates :project_id, presence: true

  # scope :find_users_tasks_by_status, lambda{ |status, user, project|
  #   {
  #     :include => :project,
  #     :order => "tasks.created_at DESC",
  #     :conditions => [ "tasks.status = :status AND projects.user_id = :user_id AND tasks.project_id = :project_id" , 
  #       { :status => Task::STATUS[status], :user_id => user.id , :project_id => project.id} ]
  #   }
  # }

  # def status
  #   STATUS.key(read_attribute(:status))
  # end

  # def status=(value)
  #    write_attribute(:status, STATUS[value])
  # end

  # def change_status()
  #   out = nil
  #   if self.status == :pending
  #     self.status = :started
  #   elsif self.status == :started
  #     self.status = :completed
  #   else
  #   end 
  #   # self.save
  # end
end
