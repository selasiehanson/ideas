require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Site Home Page" do

    before  { visit root_path }
    
    it { should have_content("Welcome") }
    
    it { should have_selector("title", text: "Ideas") }

    describe "when user has not signed in" do
      it { should have_content "SignUp" }
      it { should have_button("Click Here to Sign Up")}
    end

  end


  describe "Sigin page" do
    before { visit signin_path }
    
    it { should have_selector("h1", text: "Sign In") }
    it { should have_selector("title", text: "Sign In") }
  end
end
