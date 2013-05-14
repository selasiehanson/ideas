require 'spec_helper'

describe "NotesPages" do
	subject { page }
	
	let(:user) { FactoryGirl.create(:user, email: "k@k.com") }
	let(:p1) { FactoryGirl.create(:project, user: user) }
	

	context "When user is sginged in and is on " do 
		before do
			sign_in user
		end

		describe "projects page" do
			before { visit project_path(p1) }

			describe "notes list" do
				it { should have_selector("span.notes_count", text: "#{p1.notes.count} " )}
			end

			describe "add new note" do

				describe "with valid content" do
					before do
						fill_in "Content", with: "A new note"
					end

					it "should create a new note" do
						expect { click_button "Create Note"}.to change(Note, :count).by(1)
					end
				end

				describe "with invalid content" do
					it "shoud not add a new note" do
						expect { click_button "Create Note" }.not_to change(Note, :count)
					end
				end
				
			end

			describe "edit note" do
				let(:project) { FactoryGirl.create(:project) }
				let(:note) { FactoryGirl.create(:note, content: "some other note", project: project) }
				before { visit edit_project_note_path(project, note) }

				describe "with valid information" do
					let(:new_content) { "Some Fresh Content" }
					before do
						fill_in "Content", with: new_content
						click_button "Update Note"
					end

					specify { note.reload.content.should == new_content }
				end

				describe "with invalid information" do
					before do
						fill_in "Content", with: " "
						click_button "Update Note"
					end

					it { should have_content "Error" }
				end
			end
		end
	end

	context "when user is not signed in" do 	
		# before { get project_path(p1) }
		# specify { response.should redirect_to (root_path) }
	end
		
end