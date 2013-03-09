require 'spec_helper'

describe "ProjectCategoriesPages" do
 	subject { page }
 	let(:user) { FactoryGirl.create(:user) }
 	let(:project_category) { FactoryGirl.create(:project_category, user: user) }
 	before { sign_in user }

 	describe "project categories" do
 		
 		describe "list" do	
 			before do
	 			visit project_categories_path
	 		end
	 		it { should have_selector("h2", text: "Project Categories") }

 			# it { should have_selector("td", text: project_category.name) }	
 			# it { should have_selector("td", text: project_category.description) }
 			it { should have_selector("span", text: "#{ProjectCategory.count}" ) }
 			it { should have_selector("i", text: "Categories") }
 		end

 		describe "add new project category" do
 			before { visit project_categories_path }
 			context "with valid information" do
 				before do
 					fill_in "Name", with: "Business"
 					fill_in "Description", with: "Buisness ideas"	
 				end

 				it "should create a project category" do
 					expect { click_button "Create Project category"}.to change(ProjectCategory, :count).by(1)
 				end
 			end

 			context "with invalid information" do
 				before	 do 
 					fill_in "Name", with: ""
 				end

 				it "should not create a project category" do
 					expect { click_button "Create Project category" }.not_to change(Project, :count)
 				end
 			end
 		end

 		describe "edit project category" do
 			let!(:pct){ FactoryGirl.create(:project_category, user: user) }
 			before { visit edit_project_category_path pct }

 			context "with valid information" do
 				let(:new_name){ "New Name" }
 				before do
 					fill_in "Name", with: new_name
 					click_button "Update Project category"
 				end	

 				specify {pct.reload.name.should == new_name }
 			end

 			context "with invalid information" do
 				before	do
 					fill_in "Name", with: " "
 					click_button "Update Project category"
 				end
 				it { should have_content "Error" }
 			end
 		end
 	end
end
