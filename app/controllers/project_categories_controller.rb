class ProjectCategoriesController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update]
	before_filter :correct_project_category_owner, only: [:edit, :update]

	def index
		@project_categories = current_user.project_categories
		@project_category = ProjectCategory.new
	end

	def create
		@project_category =current_user.project_categories.build(params[:project_category])
		if @project_category.save
			flash[:success] = "Project Category created"
		else
			flash[:error] = @project_category.errors.full_messages.to_sentence
		end
		redirect_to project_categories_url
	end

	def edit
		@project_categories = current_user.project_categories
		@project_category = ProjectCategory.find(params[:id])
	end

	def update
		@project_category = ProjectCategory.find(params[:id])
		if @project_category.update_attributes(params[:project_category])
			flash[:success] = "Project Category Saved"
			redirect_to project_categories_url
		else
			flash.now[:error] = "Error : " + @project_category.errors.full_messages.to_sentence 
			@project_categories = ProjectCategory.all
			render 'edit'
		end
	end

	def correct_project_category_owner
		@project_category = current_user.project_categories.find_by_id(params[:id])
		redirect_to signin_url if @project_category.nil?
	end
end
