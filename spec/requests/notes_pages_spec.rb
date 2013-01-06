require 'spec_helper'

describe "NotesPages" do
	subject { page }
	let(:p1) { FactoryGirl.create(:project) }
	let(:user) { FactoryGirl.create(:user, email: "k@k.com") }
	before do
		sign_in user
	end 

	describe "projects page" do
		before { visit project_path(p1) }

		describe "notes list" do
			it { should have_selector("span", text: "#{p1.notes.count} notes" )}
		end


		describe "add new note" do

			describe "with valid content" do
				before do
					fill_in "Content", with: "A new note"
				end

				it "should create a new note" do
					expect { click_button "Add"}.to change(Note, :count).by(1)
				end
			end

			describe "with invalid content" do
				it "shoud not add a new note" do
					expect { click_button "Add" }.not_to change(Note, :count)
				end
			end
			
		end
	end

end