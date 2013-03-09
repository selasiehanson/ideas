require 'spec_helper'

describe "UserPages" do
  
    subject { page }

    describe "visit sign up page" do
    	before { visit signup_path }

    	it { should have_selector("h1", text: "Enter Details to Sign Up") }
    	it { should have_selector("title", text: "Sign Up") }
  	
      describe "signup" do  
        let (:submit) { "Create Account"}
        describe "with invalid information" do  
          it "should not create the account" do
            expect { click_button submit}.not_to change(User, :count)
          end
        end

        describe "with valid information " do
          before  do
            # fill_in "First Name", with: "Kofi"
            # fill_in "Last Name", with: "Poku"
            fill_in  "Name", with: "Kofi Poku"
            fill_in "Email", with: "kp@yahoo.com"
            fill_in "Password", with: "123456"
            fill_in "Confirmation", with: "123456"
          end

          it "should create a new user" do
            expect { click_button submit}.to change(User, :count).by(1)
          end
        end
      end

      describe "edit" do
          let(:user)   { FactoryGirl.create(:user) }
          before do
            sign_in user
            visit edit_user_path(user)
          end

          describe "page" do
            
          end

          describe "with invalid information" do
            before { click_button "Save changes"}
            it { should have_content "error"}
          end


          describe "with valid information" do 
            let(:new_name) { "Some New Name"}
            let(:new_email) { "som@newemail.com"}
            # user.password =  "abcdef"

            before   do
              fill_in "Name", with: new_name
              fill_in "Email", with: new_email
              fill_in "Password", with: user.password
              fill_in "Confirmation", with: user.password
              click_button "Save changes"
            end

            it {should have_selector "div.alert.alert-success" }

            specify { user.reload.name.should == new_name }
            specify { user.reload.email.should  == new_email }
          end
      end
    end



  	describe "Home" do 
  		describe "when user has signed in" do
      		
    	end
  	end
end
