class TasksController < ApplicationController

	before_filter :fetch_project, only: [:index, :update]
	def index
		@pending_tasks = Task.find_users_tasks_by_status(:pending, current_user, @project)
		@started_tasks = Task.find_users_tasks_by_status(:started, current_user, @project)
		@completed_tasks = Task.find_users_tasks_by_status(:completed, current_user, @project)
	end

	def update
		task = Task.find(params[:id])
		project = Project.find(params[:project_id])
		if params[:task][:checked]
			 task.change_status()
			if task.save
				flash[:success] = "Task has been updated."
			else
				flash[:error] = task.error.full_messages.to_sentence
			end
		else

		end
		redirect_to project_tasks_path(project)
	end

	private
		def fetch_project
			@project = Project.find(params[:project_id])
		end
end
