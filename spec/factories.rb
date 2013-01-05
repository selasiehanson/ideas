FactoryGirl.define do
	factory :user do
		name "Selasie Hanson"
		email "soundfever18@gmail.com"
		password "mascot"
		password_confirmation "mascot"
	end

	factory :project do	
		title "A project"
		user
	end
end