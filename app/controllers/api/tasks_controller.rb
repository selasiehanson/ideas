class Api::TasksController < ApplicationController
  before_filter :fetch_project, only: [:index, :create, :update]
  def index
    pending_tasks = Task.find_users_tasks_by_status(:pending, current_user, @project)
    started_tasks = Task.find_users_tasks_by_status(:started, current_user, @project)
    completed_tasks = Task.find_users_tasks_by_status(:completed, current_user, @project)

    data = { pending: pending_tasks, completed: completed_tasks, started: started_tasks }
    render :json => { data: data, message: "", success: true, total: nil }
  end

  def show
  end

  def create
    note = Note.find(params[:note_id])
    success = false
    if note
      task = Task.new(content: note.content, status: :pending, project: @project)
      if task.save
        note.destroy
        msg = "Task created successfully"
        success = true
      else
        msg =  err_msg(task)
      end
    else
      msg = "Sorry, task could not be created out of this project. Please try again."
    end

    data = task ? task : nil
    render :json => { data: data, message: msg, success: success }
  end

  def update
  end

  def destroy
  end
end
