require 'spec_helper'

describe "TaskPages" do
 subject { page }
 	let(:user) { FactoryGirl.create(:user) }
	let!(:p1) { FactoryGirl.create(:project, title: "First Project", user: user) }
	let!(:n1) { FactoryGirl.create(:note, project: p1) }

  context "when user is signed in  " do
  	
  	context "create a new task from a note" do
  		before do 
  			sign_in user
  			visit project_path(p1) 
  		end
  		
  		it "creates a project idea" do
			expect { click_button "new_task_button_#{n1.id}" }.to change(Task, :count).by(1)
		end
  	end

  	context "tasks page for a particular project" do
  		before do 
	 		sign_in user 
	 		visit project_tasks_path(p1)
	 	end

	 	it { should have_selector("h2", text: "Tasks: #{p1.title}") }
	 	it { should have_selector("span", text: "Pending") }
	 	it { should have_selector("span", text: "Started") }
	 	it { should have_selector("span", text: "Done") }
  	end


 	
 end

 context "when user is no signed in" do

 end

end
