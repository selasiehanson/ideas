# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
 	before do 
 		@user =  User.new(name: "Selasie Hanson", email: "soundfever8@gmail.com",
 			password: "foobar", password_confirmation: "foobar") 
 	end
 	subject { @user }

 	it { should respond_to(:name) }
 	it { should respond_to(:email) }
 	it { should respond_to(:password_digest) }
 	it { should respond_to(:password) }
 	it { should respond_to(:password_confirmation) }
 	it { should respond_to(:remember_token) }
 	it { should respond_to(:authenticate) }

 	it { should respond_to(:projects)}
 	it { should be_valid }


 	describe "when name is not present" do
 		before { @user.name = "" }

 		it { should_not be_valid }
 	end

 	describe "when name is too long" do
 		before { @user.name = "a" * 51 }
 		it { should_not be_valid }
 	end

 	describe "when email format is invalid" do
 		it "should be invalid" do 
 			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]

            addresses.each do |address|
            	@user.email = address
            	@user.should_not be_valid
            end		
 		end
 	end

 	describe "when email format is valid" do

 		it "should be valid" do
 			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]

	 		addresses.each do |address|
	 			@user.email = address
	 			@user.should be_valid
	 		end	
 		end
 	end

 	describe "when email addres is already taken" do
 		before do
 			other_user = @user.dup
 			other_user.email = @user.email.upcase
 			other_user.save
 		end

 		#note we are testing the original user and not the other user since we saved the other user
 		it { should_not be_valid }
 	end

 	describe "when password is short" do
 		before { @user.password = @user.password_confirmation = "a" * 5 }
 		it { should_not be_valid }
 	end

 	describe "when password is not present" do
 		before { @user.password = @user.password_confirmation = " "}
 		it { should_not be_valid }
 	end 

 	describe "when passwords do not match" do
 		before { @user.password_confirmation = "some other password" }
 		it { should_not be_valid }
 	end

 	describe "when password confirmation is nil" do
 		before { @user.password_confirmation = nil }
 		it { should_not be_valid } 
 	end

 	describe "return value of the authenticate method" do
 		before { @user.save }
 		let(:found_user) { User.find_by_email(@user.email) }

 		describe "with valid password" do
 			it { should == found_user.authenticate(@user.password) }
 		end

 		describe "with invalid password" do
 			let (:user_for_invalid_password) { found_user.authenticate("invalid") }
 			it { should_not == user_for_invalid_password }
 			specify { user_for_invalid_password.should be_false }
 		end
 	end

 	describe "remember token" do
 		before { @user.save }
 		its (:remember_token) { should_not be_blank}
 	end

 	describe "projects association" do
 		
 		before do  
 			@user.save 
 		end
 		let!(:old_project) { FactoryGirl.create(:project, user: @user, created_at: 2.day.ago) }
 		let!(:new_project) { FactoryGirl.create(:project, user: @user, created_at: 1.day.ago) }

 		it "should show the recent project first" do
 			@user.projects.should == [new_project, old_project]
 		end
 	end 

 	describe "project categories" do 
 		before { @user.save }

 		let!(:pc1) { FactoryGirl.create(:project_category, user: @user, created_at: 2.day.ago ) }
 		let!(:pc2) { FactoryGirl.create(:project_category, user: @user, created_at: 1.day.ago ) }

 		it "should show the recent project category first" do	
 			@user.project_categories[0].should == pc2
 			@user.project_categories[1].should == pc1
 		end
 	end

 	describe "has one project category as soon as a user is created," do
 		before { @user.save }
 		it "is called none" do
 			@user.project_categories.length.should == 1
 			@user.project_categories[0].name.downcase.should == 'NONE'.downcase
 		end
 	end
 end
