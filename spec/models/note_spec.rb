require 'spec_helper'

describe Note do

	let(:project) { FactoryGirl.create(:project) }

	before do
		@note = project.notes.build(content: "First Note")
	end

	subject { @note }
	
	it { should respond_to(:content) }
	it { should respond_to(:project_id) }
	it { should respond_to(:status) }

	context "Associations" do	
		it {should respond_to(:project) }
	end

	context "Validations" do
		describe "when content is not available" do
			before { @note.content = nil }
			it { should_not be_valid }
		end

		describe "when project_id is not present" do
			before { @note.project_id = nil }
			it { should_not be_valid}
		end	
	end
	
end
