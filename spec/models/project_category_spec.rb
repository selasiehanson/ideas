require 'spec_helper'

describe ProjectCategory do
  let(:user) { FactoryGirl.create(:user) }

  before do
  	@project_category = user.project_categories.build(name: "Hobby", description: "")
  end

  subject { @project_category }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its (:user) { should == user }
  it { should be_valid}

  describe "when name is not present" do
  	before{ @project_category.name = "" }
  	it { should_not be_valid }
  end
end
