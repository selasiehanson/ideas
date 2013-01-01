require 'spec_helper'

describe "StaticPages" do
  subject { page }
  describe "Site Home Page" do

    before  { visit root_path }
    
    it { should have_content("Welcome") }
    
    it { should have_selector("title", text: "Ideas") }

    # it { should have_link("Sign in") }

    # it { should_not have_link("Home") }
  end

  describe "Sign in Page" do
    # it "should"
  end
end
