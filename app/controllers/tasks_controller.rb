class TasksController < ApplicationController

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
end
