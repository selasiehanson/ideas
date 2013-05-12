require 'spec_helper'

describe Project do
  let(:user) { FactoryGirl.create(:user) }

  before do
    @project = FactoryGirl.build(:project, title: "Project One", description: "Our very first project", user: user)
  end

  subject { @project }
  
  context "Validations" do
    [:project_category_id, :title, :user_id].each do |attr|
      it "requires #{attr}" do
        subject.send("#{attr}=", nil)
        subject.should_not be_valid
        subject.errors.messages.should_not be_nil
      end
    end
  end

  context "Associations" do
    it { should respond_to(:user) }
    it { should respond_to(:project_category) }
    it { should respond_to(:notes) }
  end
  
	
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
  	it "should not allow access to user_id" do
  		expect do 
  			Project.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end
end
