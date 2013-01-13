require 'spec_helper'

describe "ProjectPages" do

	subject { page }
	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

    describe "projects" do
    	let!(:p1) { FactoryGirl.create(:project, title: "First Project", user: user) }
    	let!(:p2) { FactoryGirl.create(:project, title: "Second Project", user: user) }

	  	describe "list"  do
	  		before { visit projects_path }
	  		it { should have_selector("h2", text: "My Projects") }
	  		
	  		it { should have_content(p1.title) }		
	  		it { should have_content(p1.description) }
	  		it { should have_content(p2.title) }
	  		it { should have_content(p2.description) }
	  		it { should have_content(user.projects.count) }
	  	end

	  	describe "a single project" do
	  		before { visit project_path(p1) }

	  		it { should have_selector("h2", text: p1.title) }
	  		it { should have_selector("span", text: "#{p1.notes.count} notes")}
	  	end

	  	describe "add a new project" do
	  		describe "with valid information" do
	  			before do
	  				fill_in "Title", with: "New project"
	  				fill_in "Description", with: "New Description"
	  			end

	  			it "should create a project idea" do
	  				expect { click_button "Create Project" }.to change(Project, :count).by(1)
	  			end
	  		end

	  		describe "with invalid information" do
	  			it "should not create a project idea" do
	  				expect { click_button "Create Project" }.not_to change(Project, :count)
	  			end

	  		end
	  	end
	end


	describe "edit project" do
		let!(:p1) { FactoryGirl.create(:project, title: "First Project", user: user) }
		before { visit edit_project_path p1 }
			
		describe "with valid information" do
			let(:new_title) { "New title" }

			before do
				fill_in "Title", with: new_title
				click_button "Update Project"
			end

			specify { p1.reload.title.should == new_title }
		end

		describe "with invalid information" do
			before do
				fill_in "Title", with: " "
				click_button "Update Project"
			end

			it { should have_content "Error" }
		end
	end

	
end
