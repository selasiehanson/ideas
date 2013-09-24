class ProjectsController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :show]
	before_filter :correct_project_owner, only: [:edit, :update, :show]
	
	def index	
	end

	def show
	end

	def create
	end

	def destroy
	end

	private
	def correct_project_owner
		@project = current_user.projects.find_by_id(params[:id])
		redirect_to signin_url if @project.nil?
	end
end
