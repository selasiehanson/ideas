require 'spec_helper'

describe "Authentications" do
  subject { page }

  describe "signin page" do
  	before { visit signin_path }
  	
  	it { should have_selector("h1", text: "Sign In") }
  	it { should have_selector("title", text: "Sign In") }
  end

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

      it { should have_link("Home", href: home_path ) }
      it { should have_link("Projects", href: projects_path) }
      it { should have_link("Sign out") }
      it { should_not have_link("Sign In", href: signin_path) }

      describe "followed by sign out" do
        before { click_link "Sign out" }
        it { should have_link("Sign in") }
      end

  	end
  end
end
