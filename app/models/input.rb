class Input < ActiveRecord::Base
	STATUS = {  pending: 1,  started: 2, completed: 3 , note: 10 }.freeze

  attr_accessible :content, :status, :project
 
  validates :content, presence: true
  validates :project_id, presence: true
  validates :status, :presence => true, :inclusion => { in: STATUS }

  def status
  	STATUS.key(read_attribute(:status))
  end

  def status=(value)
    unless value.is_a?(Symbol)
      value = value.to_sym
    end
  	write_attribute(:status, STATUS[value])
  end	

end
