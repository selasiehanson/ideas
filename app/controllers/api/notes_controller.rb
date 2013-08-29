class Api::NotesController < ApplicationController
  before_filter :fetch_project_notes, :only => [:index, :create]

  def index
    notes = @notes.order("created_at DESC")
    render :json =>  { data: notes, message: "", success: true, total: notes.length }
  end

  def show
  end

  def create
    @note = @notes.build(params[:note])
    success =  false
    if @note.save
      msg = "Note successfully created."
      success = true
    else
      msg = err_msg
    end
    render :json => { data: [@note], message: msg , success: success }
  end

  def update
    success =  false
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      msg = "Note updated successfully"
      success = true
    else
      msg = err_msg
    end
    render :json => { data: [@note], message: msg , success: success }
  end

  def destroy
    note = Note.find(params[:id])
    msg = ""
    success = false
    if note.destroy
      msg = "Note deleted successfully"
      success = true
    end
    render :json => { data: nil, message: msg, success: true}
  end
  

  private 
    def fetch_project_notes
      @notes = Project.find(params[:project_id]).notes
    end

    def success_message
      
    end

    def err_msg
      "Error. #{@note.errors.full_messages.to_sentence}"
    end
end
