require 'spec_helper'

describe "Authentications" do
  subject { page }

  describe "signin" do
  	
  	before { visit signin_path }
   
  	describe "with invalid information" do 
  		before { click_button "Sign in" }

  		it { should have_selector("title", text: "Sign In") }
  		it { should have_selector("div.alert.alert-error", text: 'Invalid') }
  	end

  	describe "with valid information" do
  		let(:user) { FactoryGirl.create(:user) }

      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      # it { should have_link("Home", href: home_path ) }
      it { should have_link("Projects", href: projects_path) }
      it { should have_link("Project Categories", href: project_categories_path) }
      it { should have_link("Sign out", href: signout_path ) }
      
      it { should_not have_link("Sign In", href: signin_path) }

      describe "followed by sign out" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end

  	end

    describe "authorization" do
      
      describe "on projects for users who have NOT signed in" do
        let(:user) { FactoryGirl.create(:user) }
        let(:p1) { FactoryGirl.create(:project) }

        describe "visiting the project page" do
          before { visit projects_path }
          it { should have_selector("title", text: "Sign In") }
        end

        describe "visiting the edit project page" do
          before { visit edit_project_path(p1) }
          it { should have_selector("title", text: "Sign In") }
        end

        describe "submitting to the update action" do
          before { put project_path(p1) }
          specify { response.should redirect_to signin_path }
        end

        #todo 
        #tests for notes for unsigned users
      end

      describe "on users for users who have NOT signed in" do
        
      end
    end
  end
end
