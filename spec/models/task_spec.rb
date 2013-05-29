require 'spec_helper'

describe Task do
  let!(:project) { FactoryGirl.create(:project)  }
  
  before do
  	@task = FactoryGirl.create(:task, project: project)
  end

  subject { @task }

  it { should respond_to(:content) }
  it { should respond_to(:status) }
  it { should respond_to(:note_id) }
  
  context "Validations" do
	[:note_id, :content, :status].each do |attr|
		it "requires #{attr}" do 
			subject.send("#{attr}=", nil)
			subject.should_not be_valid
			subject.errors.messages.should_not be_nil
		end
	end
  end

  context "Associations" do
  	it { should respond_to(:note) }
  	it { should respond_to(:project) }
  end

  context "retrieving tasks based on a particular project and different status" do

    before do 
      @t1 = FactoryGirl.create(:task, project: project, status: :pending)
      @t2 = FactoryGirl.create(:task, project: project, status: :started)
      @t3 = FactoryGirl.create(:task, project: project, status: :completed)
      @user = project.user
    end

    it "should find tasks that are pending" do 
      tt = Task.find_users_tasks_by_status(:pending, @user)
      # puts tt.inspect
      tt.should == [@task,@t1]
    end

    it "should find tasks that are started" do 
      Task.find_users_tasks_by_status(:started, @user).should == [@t2]
    end

    it "should find tasks that are completed" do 
      Task.find_users_tasks_by_status(:completed, @user).should == [@t3]
    end
  end
end
