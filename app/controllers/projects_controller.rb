class ProjectsController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :show]
	before_filter :correct_project_owner, only: [:edit, :update]
	
	def index	
		@projects = current_user.projects
		#this is to allow us to create a new project
		@project = Project.new	
		@project_categories = current_user.project_categories	
	end

	def show
		@project = Project.find(params[:id])
		@notes = @project.notes
		@note = @project.notes.build
	end

	def create
		@project = current_user.projects.build(params[:project])
		if @project.save
			flash.now[:success] = "Project Idea successfully created!"		
		else
			flash.now[:error] = "Sorry something  went wrong please try again"
		end
		redirect_to projects_url
	end

	def destroy
	
	end

	def edit
		@project = Project.find(params[:id])
		@projects = current_user.projects
	end

	def update
		@project = Project.find(params[:id])
		
		@project.title = params[:project][:title]
		@project.description = params[:project][:description]
		@project.project_category = ProjectCategory.find(params[:project][:project_category_id])
		
		if @project.save
			flash.now[:success] = "Project '#{@project.title}' Updated succesffuly"
			@projects = current_user.projects
			redirect_to projects_url
		else
			# flash.now[:error] = "Error. something went wrong. Please try again"
			flash.now[:error] = @project.errors.full_messages.to_sentence
			# @projects = current_user.projects
			render "edit"	
		end
	end

	private 
	def correct_project_owner
		@project = current_user.projects.find_by_id(params[:id])
		redirect_to signin_url if @project.nil?
	end
end
