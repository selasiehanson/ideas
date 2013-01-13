class ProjectsController < ApplicationController
	def index	
		@projects = current_user.projects
		#this is to allow us to create a new project
		@project = Project.new
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

		if @project.update_attributes(params[:project])
			flash.now[:success] = "Project '#{@project.title}' Updated succesffuly"
			redirect_to projects_url
		else
			flash.now[:error] = "Error. something went wrong. Please try again"
			render 'edit'
			
		end

	end
end
