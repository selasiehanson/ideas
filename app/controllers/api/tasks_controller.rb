class Api::TasksController < ApplicationController
  def index
  end

  def show
  end

  def create
    project = Project.find(params[:project_id])
    note = Note.find(params[:note_id])
    success = false
    if note
      task = Task.new(content: note.content, status: :pending, project: project)
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
