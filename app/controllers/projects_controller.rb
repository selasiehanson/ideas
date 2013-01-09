class ProjectsController < ApplicationController
	def index	
		@projects = current_user.projects
		#this is to allow us to create a new project
		@project = Project.new
	end

	def show
		@project = Project.find(params[:id])
		@notes = @project.notes
		# @note = @project.notes.build
	end

	def create
		@project = current_user.projects.build(params[:project])
		if @project.save
			flash[:success] = "Project Idea successfully created!"		
		else
			flash[:error] = "Sorry something  went wrong please try again"
		end
		redirect_to projects_url
	end


end
