require 'spec_helper'

describe Task do
  let!(:project) { FactoryGirl.create(:project)  }
  let!(:project2) { FactoryGirl.create(:project, user: project.user)  }
  
  before do
  	@task = FactoryGirl.create(:task, project: project)
  end

  subject { @task }

  it { should respond_to(:content) }
  it { should respond_to(:status) }
 
  
  context "Validations" do
	[:content, :status].each do |attr|
		it "requires #{attr}" do 
			subject.send("#{attr}=", nil)
			subject.should_not be_valid
			subject.errors.messages.should_not be_nil
		end
	end
  end

  context "Associations" do
  	it { should respond_to(:project) }
  end

  context "retrieving tasks of a user based on a particular project and status" do

    before do 
      @t1 = FactoryGirl.create(:task, project: project, status: :pending)
      @t2 = FactoryGirl.create(:task, project: project, status: :started)
      @t3 = FactoryGirl.create(:task, project: project, status: :completed)
      @t4 = FactoryGirl.create(:task, project: project2, status: :pending)
      @user = project.user
    end

    it "should find tasks that are pending" do 
      tt = Task.find_users_tasks_by_status(:pending, @user, project)
      # puts tt.inspect
      tt.should == [@t1, @task]
    end

    it "should find tasks that are started" do 
      Task.find_users_tasks_by_status(:started, @user, project).should == [@t2]
    end

    it "should find tasks that are completed" do 
      Task.find_users_tasks_by_status(:completed, @user, project).should == [@t3]
    end
  end

  describe "should upgrade the status from a previous one to the next" do
     before { @task.change_status }
     it "should change from pending to started" do
       @task.status.should == :started
       # its (:status) { should == :started}
     end
  end

end
