FactoryGirl.define do
	factory :user do
		name "Selasie Hanson"
		sequence(:email) { |n| "person_#{n}@example.com" }
		password "mascot"
		password_confirmation "mascot"
	end


	factory :project_category do
		name "Hobby"
		description "Hobby Projects"
		user
	end

	factory :project do	
		title "A project"
		user
		project_category
	end

	factory :note do
		content "some random content"
		project
	end

	factory :task do
		content "some title"
		status :pending
		project
	end

	# factory :input do
	# 	content "some title"
	# 	status :pending
	# 	project
	# end
end