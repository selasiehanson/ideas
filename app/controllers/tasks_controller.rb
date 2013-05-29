class TasksController < ApplicationController

	def index
		@project = Project.find(params[:project_id])
		@pending_tasks = Task.find_users_tasks_by_status(:pending, current_user)
		@started_tasks = Task.find_users_tasks_by_status(:started, current_user)
		@completed_tasks = Task.find_users_tasks_by_status(:completed, current_user)
	end

	def create
		note = Note.find(params[:task][:note_id])
		project = Project.find(params[:task][:project_id])
		if note
			task = Task.new(content: note.content, note: note, status: :pending, project: project)
			if task.save
				flash[:success] = "Task created successfully"
				redirect_to project_tasks_path(project)
			else
				flash[:error] = task.errors.full_messages.to_sentence
				redirect_to project_path(project)
			end
		else
			flash[:error] = "Sorry, task could not be created out of this project. Please try again."
			redirect_to project_path(project)
		end
	end
end
