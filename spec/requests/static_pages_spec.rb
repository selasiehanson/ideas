require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Site Home Page" do

    before  { visit root_path }
    
    it { should have_content("Welcome") }
    
    it { should have_selector("title", text: "Ideas") }

    describe "when user has not signed in" do
      it { should have_content "SignUp" }
    end

    describe "when user has signed in" do
      
    end

  end

  describe "Sign in Page" do
    # it "should"
  end
end
